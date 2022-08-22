Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9889E59BFC4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiHVMxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiHVMxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 08:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C772D2E9D7;
        Mon, 22 Aug 2022 05:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382D66114E;
        Mon, 22 Aug 2022 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987DEC433C1;
        Mon, 22 Aug 2022 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661172780;
        bh=rj/ycRt2QVeN81Z/fUk7ab6KMGPqZAW+nMcstsfmS8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVWokBz+DX+bapA0CYvYHbyKforLuOEsTLIjEyTcJWhMTk1ALS7rCB+gVZQJZZ/BW
         6DMS1MWpYd2fS9o0r4X03up8Szz8YdDdiVQGHFEUXmTBg1FQBwUafpEmOHH51x69DY
         3nfhTUd1BWhTf5Ex4tmTKOCcjv2RvVwLeyvrRbQ8UoClAT1djSqJczB8p0D7Ugqjg3
         T5I/LmUSKdJ20a1VPqIDyDvUA0ufaklbS7j1hUMmTfBxDgzWR76GZbE0CEvrgTtuIx
         cB8TW2TLO4AF1hZrIO747uCVmtjLZwDwwZbFcwcPARHV4X1a8yB9cq+Xjavw/qUN+D
         6vHWX+tMizN5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ6vJ-0001ob-64; Mon, 22 Aug 2022 14:52:57 +0200
Date:   Mon, 22 Aug 2022 14:52:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Message-ID: <YwN8KR5GMZzkcMck@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <166089832025.262926.4406465315336249603.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166089832025.262926.4406465315336249603.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 10:40:49AM +0200, Lorenzo Pieralisi wrote:
> On Thu, 14 Jul 2022 09:13:40 +0200, Johan Hovold wrote:
> > This series adds support for the PCIe controllers found on SC8280XP and
> > SA8540P.
> > 
> > Included are also three patches that clean up the way the driver handles
> > different IP revisions (e.g. by modelling optional clocks as being truly
> > optional).
> > 
> > [...]
> 
> I tweaked commits as-per thread discussion (please check them, I had
> to fix minor rebase conflicts) and applied to pci/qcom, thanks!

Not sure if you missed that Stanimir had acked the whole series:

	https://lore.kernel.org/all/aa11b2ec-7196-7423-151c-1797966d0cd2@mm-sol.com/

Looks good, otherwise. Thanks!

Johan
