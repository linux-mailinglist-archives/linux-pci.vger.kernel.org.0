Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA805EAE99
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiIZRuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIZRuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 13:50:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D61A4865;
        Mon, 26 Sep 2022 10:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C60AB80B8B;
        Mon, 26 Sep 2022 17:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC080C433C1;
        Mon, 26 Sep 2022 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664212968;
        bh=4EYiYZ0wrDgSgsqkBMAwgMjP6z1zRz5Fmv8L+RYBpPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XBGoGIPobGMP16I4bFTLp4eHtOgJGOZUZHef8ebOBcb7pYrIzpxDPi39Cv3BXSbTE
         yDIpGbaDJShRsyYq50eEe0VIQT7TJCiUN3p5oqjE/QK7IvCBtUmJiPCLZLSXlH7tJY
         apt19ITXr926s7KKXqBlNpm4DCsmlFbnuabBiKWwLA9JYL0EWeVfO9kAyG2aSB+T/G
         ZsLqStUswyWHmlaVpAud1aYKUdvH2cNneaIE4hegZSo442hawm0mJq9j2jha91GKn3
         HqBU1xFvU/s7p8HS0QDiwHdI1FUCqErzpQZm911AHs8ewHGOV2UR13IMJSpttiIkU3
         6i8iuXQnYBY7Q==
Date:   Mon, 26 Sep 2022 12:22:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     allenbh@gmail.com, dave.jiang@intel.com,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        linux-pci@vger.kernel.org, jejb@linux.ibm.com, jdmason@kudzu.us,
        james.smart@broadcom.com, fancer.lancer@gmail.com,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        oohall@gmail.com, bhelgaas@google.com, dick.kennedy@broadcom.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] PCI/AER: Use pci_aer_raw_clear_status() to clear
 root port's AER error status
Message-ID: <20220926172246.GA1609538@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e025745-06af-c5c6-aa70-6ff1f9ad0962@bytedance.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 10:16:23PM +0800, Zhuo Chen wrote:
> On 9/23/22 5:50 AM, Bjorn Helgaas wrote:
> > On Fri, Sep 02, 2022 at 02:16:34AM +0800, Zhuo Chen wrote:
> > > Statements clearing AER error status in aer_enable_rootport() has the
> > > same function as pci_aer_raw_clear_status(). So we replace them, which
> > > has no functional changes.

> > > -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > > -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
> > > -	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
> > > -	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
> > > -	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
> > > -	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
> > > +	pci_aer_raw_clear_status(pdev);
> > 
> > It's true that this is functionally equivalent.
> > 
> > But 20e15e673b05 ("PCI/AER: Add pci_aer_raw_clear_status() to
> > unconditionally clear Error Status") says pci_aer_raw_clear_status()
> > is only for use in the EDR path (this should have been included in the
> > function comment), so I think we should preserve that property and use
> > pci_aer_clear_status() here.
> > 
> > pci_aer_raw_clear_status() is the same as pci_aer_clear_status()
> > except it doesn't check pcie_aer_is_native().  And I'm pretty sure we
> > can't get to aer_enable_rootport() *unless* pcie_aer_is_native(),
> > because get_port_device_capability() checks the same thing, so they
> > should be equivalent here.
> > 
> Thanks Bjorn, this very detailed correction is helpful. By the way, 'only
> for use in the EDR path' obviously written in the function comments may be
> better. So far only commit log has included these.

Yes, definitely!  I goofed when I applied that patch without making
sure there was something in the function comment.

Bjorn
