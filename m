Return-Path: <linux-pci+bounces-35133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A973B3C066
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707F81C82763
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD563093DB;
	Fri, 29 Aug 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiD2cadK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89F2B9A8;
	Fri, 29 Aug 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484060; cv=none; b=pa45Sg8LzYAKRLOp7C+/q9kz08C42BiSHb0N9yW82EWn5Khk1vv4f+jCr/HIr3XMbe42Op/CEpittgXiK+oc538P3OmRoR/L4fG7wJTXZQ7Q/Cu97Ss3zxV6c4zx9sbaEJwSf+fSQynIfdaYQkaTlz2vOPilPTgg8YPbpzGAhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484060; c=relaxed/simple;
	bh=9/2QQ3RiREaiSyUiO5ececD/jqVoWkLkjCUAA6bmPFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfG1gkYasoDWDmCW1sMkApEUhkanpbEi9RrUFREEjVdb5KEEzJPQX7jDGUGWr6is4zDa9tiDWhgj5UO8IPtlx/uZFB0WBy8TuxqRNEbxSym4xy9i26q5LPpA7GG1w/FD/AJ2YZkVkHDJvgWRhturckCqLyzy5NK0L5rs2QBODcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiD2cadK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E018EC4CEF0;
	Fri, 29 Aug 2025 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756484058;
	bh=9/2QQ3RiREaiSyUiO5ececD/jqVoWkLkjCUAA6bmPFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiD2cadK21kq8/1+HU/s47ctfSPLku5kGvKTU7+gDfo/gUItwd4dziv5/tFHyDjA3
	 dACICfHN5ycuJ0zCVyJEGvOUCEHo//mnsfRwQ0n8QYvaRL+jNuTCE0uxiPycoOxfKJ
	 Rc2x7zplfineGU0ObrNOZgLV2N4Sh3IaCMgloqtMAMIQrcMYD0+vOso4yZir1v0vsn
	 aIPXp3BW/jRTHj7UtQZMK2uucxb/dAmf7R2VDOHrWTFipB+9j+an/6BSfP8W67y0y6
	 DvOdYSsic046Ef3N9iAMNudz19ePRAzBC5VHmfwZrqilD+dK33LmRJ99TJKxjMskcQ
	 dOzixjq9Ekf4w==
Date: Fri, 29 Aug 2025 21:44:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <lakgphb7ym3cybwmpdqyipzi4tlkwbfijzhd4r6hvhho3pc7iu@6ludgw6wqkjh>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
 <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
 <aJ743hJw-T9y3waX@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ743hJw-T9y3waX@ryzen>

On Fri, Aug 15, 2025 at 11:07:42AM GMT, Niklas Cassel wrote:
> Hello Mani,
> 
> Sorry for the delayed reply.
> I just came back from vacation.
> 
> On Thu, Jul 24, 2025 at 11:00:05AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 18, 2025 at 12:39:50PM GMT, Niklas Cassel wrote:
> > > On Fri, Jul 18, 2025 at 12:28:44PM +0200, Niklas Cassel wrote:
> > > > On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > 2) Testing link down reset:
> > > > 
> > > > selftests before link down reset:
> > > > # FAILED: 14 / 16 tests passed.
> > > > 
> > > > ## On EP side:
> > > > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> > > >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > > > 
> > > > 
> > > > [  111.137162] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> > > > [  111.137881] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
> > > > [  111.138432] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
> > > > [  111.139067] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> > > > [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> > > > [  111.255407] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
> > > > [  111.256019] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
> > > > [  111.383401] pcieport 0000:00:00.0: Root Port has been reset
> > > > [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
> > > > [  111.384582] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
> > > > [  111.385218] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
> > > > [  111.385771] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
> > > > [  111.390866] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > > [  111.391650] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > > > 
> > > > Basically all tests timeout
> > > > # FAILED: 1 / 16 tests passed.
> > > > 
> > > > Which is the same as before this patch series.
> > > 
> > > The above was with CONFIG_PCIEAER=y
> > > 
> > 
> > This is kind of expected since the pci_endpoint_test driver doesn't have the AER
> > err_handlers defined.
> 
> I see.
> Would be nice if we could add them then, so that we can verify that this
> series is working as intended.
> 
> 
> > 
> > > Wilfred suggested that I tried without this config set.
> > > 
> > > However, doing so, I got the exact same result:
> > > # FAILED: 1 / 16 tests passed.
> > > 
> > 
> > Interesting. Could you please share the dmesg log like above.
> 
> It is looking exactly like the dmesg above
> 
> [   86.820059] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> [   86.820791] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
> [   86.821344] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
> [   86.821978] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [   87.040551] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
> [   87.041138] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
> [   87.168378] pcieport 0000:00:00.0: Root Port has been reset
> [   87.168882] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
> [   87.169519] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
> [   87.272463] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
> [   87.277552] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [   87.278314] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> except that we don't get the:
> > [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> > [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
> 

Ok, thanks for the logs. I guess what is happening here is that we are not
saving/restoring the config space of the devices under the Root Port if linkdown
is happens. TBH, we cannot do that from the PCI core since once linkdown
happens, we cannot access any devices underneath the Root Port. But if
err_handlers are available for drivers for all devices, they could do something
smart like below:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c4e5e2c977be..9aabf1fe902e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -989,6 +989,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
        pci_set_drvdata(pdev, test);
 
+       pci_save_state(pdev);
+
        id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
        if (id < 0) {
                ret = id;
@@ -1140,12 +1142,31 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
 
+static pci_ers_result_t pci_endpoint_test_error_detected(struct pci_dev *pdev,
+                                              pci_channel_state_t state)
+{
+       return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t pci_endpoint_test_slot_reset(struct pci_dev *pdev)
+{
+       pci_restore_state(pdev);
+
+       return PCI_ERS_RESULT_RECOVERED;
+}
+
+static const struct pci_error_handlers pci_endpoint_test_err_handler = {
+       .error_detected = pci_endpoint_test_error_detected,
+       .slot_reset = pci_endpoint_test_slot_reset,
+};
+
 static struct pci_driver pci_endpoint_test_driver = {
        .name           = DRV_MODULE_NAME,
        .id_table       = pci_endpoint_test_tbl,
        .probe          = pci_endpoint_test_probe,
        .remove         = pci_endpoint_test_remove,
        .sriov_configure = pci_sriov_configure_simple,
+       .err_handler    = &pci_endpoint_test_err_handler,
 };
 module_pci_driver(pci_endpoint_test_driver);

This essentially saves the good known config space during probe and restores it
during the slot_reset callback. Ofc, the state would've been overwritten if
suspend/resume happens in-between, but the point I'm making is that unless all
device drivers restore their known config space, devices cannot be resumed
properly post linkdown recovery.

I can add a patch based on the above diff in next revision if that helps. Right
now, I do not have access to my endpoint test setup. So can't test anything.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

