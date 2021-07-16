Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4D3CB6AC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhGPL0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 07:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232222AbhGPL0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 07:26:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8AC86023B;
        Fri, 16 Jul 2021 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626434533;
        bh=ymtVNzxVfN5KdOU5IVgRxYIYYFfih2gnBtxs8vuCWsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqySXf0xk+WtUBkYRn+1USXOUzZswQn16313q7bEOl9g16Nvj44nSVne1gIzInUIL
         e+3B5+dlV9dxOc/HDmTHoYszcErOm9gGBoMYNjdgbtrSoN6GbqbD+ZRAvlu3AqKCQj
         rM1yxRR+EP6Sc3+7kPirVxruYEEjBp/PWXfi6PY3Tlwu+kmTJbmPe9oYih5mK1+At0
         /07dDgiWv8qlbDokoBlSXhsCnJuLUcz7wgsY1wjvvBV/Tc7KMLZG6Nf2v6ckkUiIEp
         DOofZNWoxwQPuyCFbWGPaPIBGyMsBEab+PzThNBEsd43jTy0sUu6f166sHUAiimLH4
         bczQLX2Qm4CBg==
Date:   Fri, 16 Jul 2021 13:22:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/8] dt-bindings: PCI: kirin: Drop PHY properties
Message-ID: <20210716132208.3cd8f404@coco.lan>
In-Reply-To: <20210714022849.GA1330659@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022849.GA1330659@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 13 Jul 2021 20:28:49 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Jul 13, 2021 at 08:28:37AM +0200, Mauro Carvalho Chehab wrote:
> > There are several properties there that belong to the PHY
> > interface. Drop them, as a new binding file will describe
> > the PHY properties for Kirin 960.  
> 
> Folks are okay with an incompatible change on hikey960?

Accepting an incompatible change here seems the right thing to do.

Another possibility would be to create a "pcie-kirin-with-phy" driver
that would be identical to the existing one, except for the absence
of a PHY and using a different compatible string.

-

Long answer:

There aren't many alternatives here, if we want to split the PHY out of
the driver, as you requested.

I've been scratching my head in order to find a way that would keep
the Hikey960 a separate PHY driver, with a proper DT schema, but
capable of also parse the original DT schema.

See, making the phy driver parse the PCIE-based OF-node data is 
trivial (I have already a patch doing that), but it will require at
least some DT schema additions, in order to add a pcie_phy node[1]:

<snip>
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index e0eca598af1f..6aaa2f966d74 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1001,6 +1001,11 @@ spi3: spi@ff3b3000 {
                        status = "disabled";
                };
 
+               pcie_phy: pcie-phy@f3f2000 {
+                       compatible = "hisilicon,hi960-pcie-phy";
+                       #phy-cells = <0>;
+               };
+
                pcie@f4000000 {
                        compatible = "hisilicon,kirin960-pcie";
                        reg = <0x0 0xf4000000 0x0 0x1000>,
@@ -1012,6 +1017,7 @@ pcie@f4000000 {
                        #address-cells = <3>;
                        #size-cells = <2>;
                        device_type = "pci";
+                       phys = <&pcie_phy>;
                        ranges = <0x02000000 0x0 0x00000000
                                  0x0 0xf6000000
                                  0x0 0x02000000>;
</snip>

[1] or, alternatively, the pcie-kirin driver would need to dynamically
    populate DT with the above, as some ACPI drivers do when the
    firmware is broken.

Without a PHY representation at the DT schema, the PHY driver won't 
be recognized by pcie-kirin.

See, even if the pcie-kirin driver would be changed to register
the PHY without DT, with:

	phy = devm_of_phy_get(dev, NULL, "hi3660_pcie_phy");

The phy_get() implementation will internally ignore a non-DT PHY,
as internally, it uses of_property_match_string() if the caller driver
has of_node:

	struct phy *phy_get(struct device *dev, const char *string)
	{
		int index = 0;
		struct phy *phy;
		struct device_link *link;

		if (dev->of_node) {
			if (string)
				index = of_property_match_string(dev->of_node, "phy-names",
					string);
			else
				index = 0;
			phy = _of_phy_get(dev->of_node, index);
		} else {
			if (string == NULL) {
				dev_WARN(dev, "missing string\n");
				return ERR_PTR(-EINVAL);
			}
			phy = phy_find(dev, string);
		}

Thanks,
Mauro
