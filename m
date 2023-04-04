Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D76D5B7B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjDDJGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjDDJGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 05:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EBE62;
        Tue,  4 Apr 2023 02:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A455E62F5E;
        Tue,  4 Apr 2023 09:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD29C433EF;
        Tue,  4 Apr 2023 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680599164;
        bh=SJEEua9GRU1BDOjfavC76lqjXcxHCPm7HsR7H2YQ8is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAb/KsPmnLOxfNCeeyzXBvJpMEuDj+jLR4cpromxfT1FkuxBqR34VG52A5HVVGnTA
         Ecavtxby+AFxTT8uLOFj12k35d5R7Ux7gdtkyPd2KakrGUlaRPli8yQj436RpKYXh9
         6UrusM1+46XHOGuLR3Cq202muINHIy9NW17jSllO8Njk+89L0oDml8e7jY5bCQmPTa
         po+GomdVEMwC1UQON+JqFjz82QkwMnXfUuq8QlEKqfYE17D5WQf/Mxwfu3Je0qpQPn
         zrYu/rPDfKUzjHG5newmBs5iF/FCacjC1/uA87MjnIKm7VQw9MNk0ZvQnr16JOjlLv
         6fA2cTJ/Zfupw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjccY-0005mm-M9; Tue, 04 Apr 2023 11:06:30 +0200
Date:   Tue, 4 Apr 2023 11:06:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v4 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <ZCvols6SivUpIbk8@hovoldconsulting.com>
References: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
 <20230403154922.20704-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403154922.20704-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 03, 2023 at 09:19:22PM +0530, Manivannan Sadhasivam wrote:
> During the system suspend, vote for minimal interconnect bandwidth (1KiB)
> to keep the interconnect path active for config access and also turn OFF
> the resources like clock and PHY if there are no active devices connected
> to the controller. For the controllers with active devices, the resources
> are kept ON as removing the resources will trigger access violation during
> the late end of suspend cycle as kernel tries to access the config space of
> PCIe devices to mask the MSIs.
> 
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
> 
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
> 
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> +	/*
> +	 * Set minimum bandwidth required to keep data path functional during
> +	 * suspend

Nit: For some reason you dropped the full stop ('.') here in v4 I
noticed when comparing the diff.

> +	 */

Looks good to me now otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
