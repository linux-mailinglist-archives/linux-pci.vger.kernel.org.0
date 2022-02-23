Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E94C19F8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 18:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiBWRks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 12:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbiBWRkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 12:40:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298FA19B;
        Wed, 23 Feb 2022 09:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2965961483;
        Wed, 23 Feb 2022 17:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B72DC340E7;
        Wed, 23 Feb 2022 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645638016;
        bh=vdNxr48kXvnOvyGZXeXUt9F8EvQ0/KBfD8xz+E+eWzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sygr+3AqUbbfFMiGflScjFAz1W52Di4MmF0D0l2kQMvn2JhrwmdY9yJkV79q9+VWp
         j17Sirc+t3iRW5seOsuj15K0pgP5Yl8omqqV+cdwH2WeztviMmdR5tMFuHQTpyVap1
         Z4t+jPZwWmb7AnIHcH1D0dKZBj4hFvKHr3Nz7q/OSSK6/D1mc+lyphro88kPSchX8h
         LdDASysYmj4PV5kn1SjzzI9fJQAdKaEf0jUaM6N4JWzkNeVX+8CFHTGhW3HcL6BO41
         LMsD2e0HFXYmKWDXtc/pWIDzRNSajCA2yOqLtDZnbG/oz2y03r01+F1JMxHH24ARaY
         2/XCNahlftZgw==
Date:   Wed, 23 Feb 2022 11:40:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 8/8] PCI: imx6: Add the compliance tests mode support
Message-ID: <20220223174014.GA139367@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644992463-14467-9-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

s/Add the/Add/

On Wed, Feb 16, 2022 at 02:21:03PM +0800, Richard Zhu wrote:
> Refer to the system board signal Quality of PCIe archiecture PHY test
> specification. Signal quality tests(for example: jitters,  differential
> eye opening and so on ) can be executed with devices in the
> polling.compliance state.

s/archiecture/architecture/
s/tests(for/tests (for/
s/jitters,  /jitter, /              (remove double space)
s/so on )/so on)/

Is this a reference to a spec?  If so, I can't tell the name of the
spec, the revision, or the section number.

> To let the device support polling.compliance stat, the clocks and powers
> shouldn't be turned off when the probe of device driver is failed.

s/stat/state/
s/powers/power/
s/driver is failed/driver fails/

> Based on CLB(Compliance Load Board) Test Fixture and so on test
> equipments, the PHY link would be down during the compliance tests.
> Refer to this scenario, add the i.MX PCIe compliance tests mode enable
> support, and keep the clocks and powers on, and finish the driver probe
> without error return.

s/CLB(Compliance/CLB (Compliance/

> Use the "pci_imx6.compliance=1" in kernel command line to enable the
> compliance tests mode.

Thanks for including this in the commit log!

>  	ret = dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie_cmp_mode) {
> +			dev_info(dev, "Driver loaded with compliance test mode enabled.\n");

To match other messages:

s/Driver loaded/driver loaded/
s/enabled./enabled/

> +			ret = 0;
> +		} else {
> +			dev_err(dev, "Unable to add pcie port.\n");

s/Unable/unable/
s/pcie/PCIe/
s/port./port/

> +		}
>  		return ret;
> +	}
>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> -- 
> 2.25.1
> 
