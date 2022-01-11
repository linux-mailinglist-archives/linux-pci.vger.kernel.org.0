Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20C48B566
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiAKSJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 13:09:09 -0500
Received: from foss.arm.com ([217.140.110.172]:50314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232636AbiAKSJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jan 2022 13:09:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F797D6E;
        Tue, 11 Jan 2022 10:09:08 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 324F83F766;
        Tue, 11 Jan 2022 10:09:07 -0800 (PST)
Date:   Tue, 11 Jan 2022 18:09:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, bhelgaas@google.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220111180901.GA29495@lpieralisi>
References: <20220111073312.GA12633@kili>
 <CANCKTBsV1yn-tntVHNeaEOSkpAmz9fxu9bjzgMYvFv96=+437Q@mail.gmail.com>
 <fb32020a-c6a1-acc0-b5f8-ebdd84c2c31f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb32020a-c6a1-acc0-b5f8-ebdd84c2c31f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Bjorn, linux-pci]

On Tue, Jan 11, 2022 at 08:37:59AM -0800, Florian Fainelli wrote:
> +Lorenzo,
> 
> On 1/11/2022 8:02 AM, Jim Quinlan wrote:
> > On Tue, Jan 11, 2022 at 2:33 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > 
> > > Hello Jim Quinlan,
> > > 
> > > This is a semi-automatic email about new static checker warnings.
> > > 
> > > The patch 31d8fedc2827: "PCI: brcmstb: Add control of subdevice
> > > voltage regulators" from Jan 6, 2022, leads to the following Smatch
> > > complaint:
> > > 
> > >      drivers/pci/controller/pcie-brcmstb.c:1404 brcm_pcie_resume()
> > >      error: we previously assumed 'pcie->sr' could be null (see line 1350)
> > > 
> > > drivers/pci/controller/pcie-brcmstb.c
> > >    1349
> > >    1350          if (pcie->sr) {
> > >                      ^^^^^^^^
> > > Check for NULL
> > > 
> > >    1351                  if (pcie->ep_wakeup_capable) {
> > >    1352                          /*
> > >    1353                           * We are resuming from a suspend.  In the suspend we
> > >    1354                           * did not disable the power supplies, so there is
> > >    1355                           * no need to enable them (and falsely increase their
> > >    1356                           * usage count).
> > >    1357                           */
> > >    1358                          pcie->ep_wakeup_capable = false;
> > >    1359                  } else {
> > >    1360                          ret = regulator_bulk_enable(pcie->sr->num_supplies,
> > >    1361                                                      pcie->sr->supplies);
> > >    1362                          if (ret) {
> > >    1363                                  dev_err(dev, "Could not turn on regulators\n");
> > >    1364                                  goto err_disable_clk;
> > >    1365                          }
> > >    1366                  }
> > >    1367          }
> > >    1368
> > >    1369          ret = reset_control_reset(pcie->rescal);
> > >    1370          if (ret)
> > >    1371                  goto err_regulator;
> > >    1372
> > >    1373          ret = brcm_phy_start(pcie);
> > >    1374          if (ret)
> > >    1375                  goto err_reset;
> > >    1376
> > >    1377          /* Take bridge out of reset so we can access the SERDES reg */
> > >    1378          pcie->bridge_sw_init_set(pcie, 0);
> > >    1379
> > >    1380          /* SERDES_IDDQ = 0 */
> > >    1381          tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > >    1382          u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> > >    1383          writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > >    1384
> > >    1385          /* wait for serdes to be stable */
> > >    1386          udelay(100);
> > >    1387
> > >    1388          ret = brcm_pcie_setup(pcie);
> > >    1389          if (ret)
> > >    1390                  goto err_reset;
> > >    1391
> > >    1392          ret = brcm_pcie_linkup(pcie);
> > >    1393          if (ret)
> > >    1394                  goto err_reset;
> > >    1395
> > >    1396          if (pcie->msi)
> > >    1397                  brcm_msi_set_regs(pcie->msi);
> > >    1398
> > >    1399          return 0;
> > >    1400
> > >    1401  err_reset:
> > >    1402          reset_control_rearm(pcie->rescal);
> > >    1403  err_regulator:
> > >    1404          regulator_bulk_disable(pcie->sr->num_supplies, pcie->- sr->supplies);
> > >                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Unchecked dereferences.  I think we do need to add a check?
> > Absolutely, "if (pcie->sr)".  What do I need to do - send a fixup or a
> > new full pullreq?  I'm not quite sure if this was accepted yet....
> 
> Your patch series has been queued up in Lorenzo's tree here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/brcmstb
> 
> so I suppose you could submit an incremental patch to fix the error
> reported by Dan and Lorenzo can either squash it or just leave it as a
> fix on top?

Please send a fix to Bjorn and CC linux-pci as soon as possible, he may
be able to squash that in before sending a PR.

Thanks,
Lorenzo
