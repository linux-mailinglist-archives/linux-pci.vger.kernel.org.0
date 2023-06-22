Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9D739E8F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 12:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjFVK1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFVK1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 06:27:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5BDD;
        Thu, 22 Jun 2023 03:27:45 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687429664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H06oSbr3Du/eEXPm8XFnjl764DcfY5pI+eVbCkQeU/c=;
        b=Y4KkQctzSRfoYVOWO+/Aehek4dJtnhZooCBOuUH0t7WfbfjhqzFn+c70kFOj/xtMhJf9E6
        /wePicyYmoqFecsch6id/98MK1be3FB+sBSIfHH2TMXDVpLcmfjbXCed2j4LgSgCCfOP+n
        DcKCtq/Qj+qnxHdljcjiO8nggDAo0T5xAxKTurrxgi/Brj7/V246fbbZt49C11qW9p0kso
        gR2bK+aM2szaXVTfeKxeO8xm1r5lX7S3rkvwA3F3XppyNIdvf8bq8sbOeUVTN8IGB0NYfx
        6x4y/WmlgJgxmezkCr/YoIqHNrUMkCp/JLRUrBasGogcXGtm8SwAIGpwl7r2lQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C2BB20008;
        Thu, 22 Jun 2023 10:27:43 +0000 (UTC)
Date:   Thu, 22 Jun 2023 12:27:42 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH V9 5/5] of: unittest: Add pci_dt_testdrv pci driver
Message-ID: <20230622122742.379a34d2@bootlin.com>
In-Reply-To: <1687368849-36722-6-git-send-email-lizhi.hou@amd.com>
References: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
        <1687368849-36722-6-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

On Wed, 21 Jun 2023 10:34:09 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> pci_dt_testdrv is bound to QEMU PCI Test Device. It reads
> overlay_pci_node fdt fragment and apply it to Test Device. Then it
> calls of_platform_default_populate() to populate the platform
> devices.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/of/unittest-data/Makefile             |   3 +-
>  .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
>  drivers/of/unittest.c                         | 188 ++++++++++++++++++
>  drivers/pci/quirks.c                          |   1 +
>  4 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso

Did the test under QEMU with the instructions that Lizhi provided at
  https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/README

The unittest results were:
--- 8< ---
[    1.107378] ### dt-test ### pass of_unittest_lifecycle():3273
[    1.110068] ### dt-test ### pass of_unittest_pci_node():3909
[    1.110401] ### dt-test ### pass unittest_pci_probe():3840
[    1.110618] ### dt-test ### pass of_unittest_pci_node():3914
[    1.110759] ### dt-test ### pass of_unittest_pci_node_verify():3870
[    1.110894] ### dt-test ### pass of_unittest_pci_node_verify():3877
[    1.110985] ### dt-test ### pass of_unittest_pci_node_verify():3884
[    1.111088] ### dt-test ### pass of_unittest_pci_node():3926
[    1.111171] ### dt-test ### pass of_unittest_pci_node():3927
[    1.112056] ### dt-test ### pass of_unittest_pci_node_verify():3870
[    1.112201] ### dt-test ### pass of_unittest_pci_node_verify():3890
[    1.112326] ### dt-test ### pass of_unittest_pci_node_verify():3892
[    1.112489] ### dt-test ### pass of_unittest_check_tree_linkage():271
--- 8< ---

Based on the test provided, no failure detected.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Further more, I dumped the dt (PCI related nodes) available on the target.
If someone needs to look at it:
--- 8< ---
# cat /tmp/dt.dts 
/dts-v1/;

/ {
	#address-cells = <0x02>;
	#size-cells = <0x02>;
	interrupt-parent = <0x8002>;
	compatible = "linux,dummy-virt";
	name = [00];
[...]
	pcie@10000000 {
		#address-cells = <0x03>;
		dma-coherent;
		bus-range = <0x00 0xff>;
		interrupt-map = <0x00 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x03 0x04 0x00 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x04 0x04 0x00 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x05 0x04 0x00 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x04 0x04 0x800 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x05 0x04 0x800 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x05 0x04 0x1000 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x06 0x04 0x1000 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x06 0x04 0x1800 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x03 0x04 0x1800 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x05 0x04>;
		#size-cells = <0x02>;
		device_type = "pci";
		interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
		compatible = "pci-host-ecam-generic";
		ranges = <0x1000000 0x00 0x00 0x00 0x3eff0000 0x00 0x10000 0x2000000 0x00 0x10000000 0x00 0x10000000 0x00 0x2eff0000 0x3000000 0x80 0x00 0x80 0x00 0x80 0x00>;
		#interrupt-cells = <0x01>;
		reg = <0x40 0x10000000 0x00 0x10000000>;
		linux,pci-domain = <0x00>;
		msi-parent = <0x8003>;
		name = "pcie";

		pci@3,0 {
			#address-cells = <0x03>;
			#size-cells = <0x02>;
			device_type = "pci";
			compatible = "pci1b36,c\0pciclass,060400\0pciclass,0604";
			ranges = <0x81001800 0x00 0x1000 0x81001800 0x00 0x1000 0x00 0x2000 0x82001800 0x00 0x10000000 0x82001800 0x00 0x10000000 0x00 0x200000 0xc3001800 0x80 0x00 0xc3001800 0x80 0x00 0x00 0x200000>;
			reg = <0x1800 0xffff6d76 0xc2b23600 0xffff6d76 0x3fbf63a0>;

			pci@0,0 {
				#address-cells = <0x03>;
				#size-cells = <0x02>;
				device_type = "pci";
				compatible = "pci104c,8232\0pciclass,060400\0pciclass,0604";
				ranges = <0x81010000 0x00 0x1000 0x81010000 0x00 0x1000 0x00 0x1000 0x82010000 0x00 0x10000000 0x82010000 0x00 0x10000000 0x00 0x200000 0xc3010000 0x80 0x00 0xc3010000 0x80 0x00 0x00 0x200000>;
				reg = <0x10000 0xffff6d76 0xc2b32580 0xffff6d76 0xc2b1f000>;

				pci@0,0 {
					#address-cells = <0x03>;
					#size-cells = <0x02>;
					device_type = "pci";
					compatible = "pci104c,8233\0pciclass,060400\0pciclass,0604";
					ranges = <0x81020000 0x00 0x1000 0x81020000 0x00 0x1000 0x00 0x1000 0x82020000 0x00 0x10000000 0x82020000 0x00 0x10000000 0x00 0x200000 0xc3020000 0x80 0x00 0xc3020000 0x80 0x00 0x00 0x200000>;
					reg = <0x20000 0xffff6d76 0xc2b3f880 0xffff6d76 0xc2b30400>;

					dev@0,0 {
						#address-cells = <0x03>;
						#size-cells = <0x02>;
						compatible = "pci1b36,5\0pciclass,00ff00\0pciclass,00ff";
						ranges = <0x00 0x00 0x00 0x82030000 0x00 0x10000000 0x00 0x1000 0x01 0x00 0x00 0x81030000 0x00 0x1000 0x00 0x100>;
						reg = <0x30000 0xffff6d76 0xc2b42800 0xffff6d76 0xc2b30800>;
					};
				};
			};
		};

		pci@3,1 {
			#address-cells = <0x03>;
			#size-cells = <0x02>;
			device_type = "pci";
			compatible = "pci1b36,c\0pciclass,060400\0pciclass,0604";
			ranges = <0x81001900 0x00 0x3000 0x81001900 0x00 0x3000 0x00 0x1000 0x82001900 0x00 0x10200000 0x82001900 0x00 0x10200000 0x00 0x200000 0xc3001900 0x80 0x200000 0xc3001900 0x80 0x200000 0x00 0x200000>;
			reg = <0x1900 0xffff6d76 0xc2b29280 0xffff6d76 0x3fbf63a0>;
		};

		pci@4,0 {
			#address-cells = <0x03>;
			#size-cells = <0x02>;
			device_type = "pci";
			compatible = "pci8086,244e\0pciclass,060401\0pciclass,0604";
			ranges = <0x82002000 0x00 0x10400000 0x82002000 0x00 0x10400000 0x00 0x100000>;
			reg = <0x2000 0xffff6d76 0xc2b32d80 0xffff6d76 0x3fbf63a0>;

			pci@0,0 {
				#address-cells = <0x03>;
				#size-cells = <0x02>;
				device_type = "pci";
				compatible = "pci1b36,1\0pciclass,060400\0pciclass,0604";
				ranges;
				reg = <0x50000 0xffff6d76 0xc2b49780 0xffff6d76 0xc2b30100>;
			};
		};
	};

[...]

};
--- 8< ---

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
