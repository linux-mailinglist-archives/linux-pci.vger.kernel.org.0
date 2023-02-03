Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A316A68945F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjBCJuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjBCJuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:50:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D532CC7F;
        Fri,  3 Feb 2023 01:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DAB0B82A28;
        Fri,  3 Feb 2023 09:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24351C433EF;
        Fri,  3 Feb 2023 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675417814;
        bh=T/9LxE7WE8hNMmPu7X+WMeI+t2/HXTaNVNYlFa2pJSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGGnspMNgxmcjE2WsurdbifSi99UposcFBub8O8/rdgBeXjCbI81B6rmOb/oXjbty
         6NtbZRgMk19wigVNXUrITCNbWKE86AmMosTcHnbRynNvvIIOt8pnTuwN4jA1omfemj
         5Oilpis8mpcZQAr7UdVaxu99LMMgIikf4SXZWRmhwN5qvleNfEszRBQsmazsFNKbQ8
         8KrRvbfvO1jYk2Fq22BgfIIvzOftfn8IGSZebAiF4JQurOIQSv8fLHLjDacwsJg+nD
         2ZAx+LJKTWPwqHZQDqV6fHTN7/fq7r/MxGCaB7dSZPFWLf4Z0EdVJp0tRJ2fjzBxGk
         3mET6IY9qEGAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNsiO-0000ur-IV; Fri, 03 Feb 2023 10:50:40 +0100
Date:   Fri, 3 Feb 2023 10:50:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y9zY8L2OhRacl8Qf@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-12-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203081807.2248625-12-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 10:18:06AM +0200, Abel Vesa wrote:
> Add PCIe controllers and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Looks good to me know:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
