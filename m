Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A07F1DF6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjKTUXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 15:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTUXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 15:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E25C7;
        Mon, 20 Nov 2023 12:23:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F93C433C7;
        Mon, 20 Nov 2023 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700511796;
        bh=64qT/wOcuw4k4+n5Kkq7uUCAVlOExcQnfX8RYUHstxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oiQoXXH+fHhQ8ndFf5xJd3rDSNoEHrh4y0K7iRrAw5ojNcpZyaGzHXmKFM3eaW+U5
         +PeKzdbMZ+FAlFqWLu9kfUfBtNhiXC2cnNnvKXM/3FdAMp5oE/jQDUBLHJqU+RbRxv
         9j2ZUbYcrDMqTVFO4WWqoHztAB0fMIsv53hospjik/2ImIjIBASi9Ohp1fOwJZaQMf
         OG7cDYW5VD/+8oP9chj4sONb8pbuMRTA2a5oHge34DrkKZrDB6juoAdjIdCZNxoWhY
         z+NfTe2aefBjjNj8j2YWSTar2k1yFTSnD36J8big6mlLZ0jBVYDHiQ0pls2brkOHtW
         alts96V2/jVSw==
Date:   Mon, 20 Nov 2023 14:23:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com
Subject: Re: [PATCH v2] PCI: qcom: Set max payload size 256 bytes for IPQ9574
Message-ID: <20231120202314.GA211658@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726104249.534210-1-quic_ipkumar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 04:12:49PM +0530, Praveenkumar I wrote:
> This patch sets 256 bytes as payload size for IPQ9574. This allows
> PCIe RC to use the max payload size when a capable link partner is
> connected.

I'm confused because this patch doesn't apply to v6.7-rc1, and I don't
see qcom_pcie_post_init_1_27_0() or IPQ9574 mentioned in the git
history.  Maybe this depends on some out-of-tree patch?

I think this commit log should explain why the existing code in the
PCI core doesn't do what's needed.  Is there something qcom-specific
about this issue?

Maybe an example including the DEVCAP Max_Payload_Size Supported and
the DEVCTL Max_Payload_Size for both ends of the link would help
understand what's going wrong.

Does this setting get lost after suspend?  Does it need to be updated
again after suspend/resume?

> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v2]:
> 	Dropped cover letter for this patch. Configured the max payload
> 	in the post_init of IPQ9574 instead for early fixup.
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8ee7c2b5de27..739c0d514a96 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1145,6 +1145,15 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
>  {
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_DEVCTL);
> +	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +	val |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_DEVCTL);
> +
>  	writel(SLV_ADDR_SPACE_SZ_1_27_0,
>  	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>  
> -- 
> 2.34.1
> 
