Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573E7203EE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjFBOCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjFBOCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 10:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506A1B7
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 07:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2A660AB7
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 14:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E914C433EF;
        Fri,  2 Jun 2023 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685714530;
        bh=CP7bCkgW1kNHlplMR66pVo+51xxh32dfuBZsJjpN+DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=apJ3CDLQZk2frf/cSz8Gz1F0Y9ABbkrKp9p4Ic1pw+dPUHWhPeutdTDTOC34A1J7I
         fk/lilDTKswIWWiSlZFXXLtwJUvxOJBAFRSttf0nky2WYBgw6ypqWG2ZLbyRtFRU9i
         0NMaQyUjCjwMOi6OcDYr+Vn230CW3hkZmRuDmX+ezyX9kRxkXaOk/WevOBTmxPvsPF
         934H9W1jtUEMVQRq2Lap8eWIxjwXC5/vColAswq+tzKEmLafcfNTPzA7Eihv9m8hws
         IlLFCRVNSxSHCfn9zTDZgI6auzY8nDR16qr4JpaBbq5p4DWL8V6Mb0yJzAauY5KcRr
         5tCu4ps7Qs1Dw==
Date:   Fri, 2 Jun 2023 09:02:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-pci@vger.kernel.org,
        bhelgaas@google.com,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
Subject: Re: [PATCHv2] pci: add PCI_EXT_CAP_ID_PL_32GT define
Message-ID: <ZHn2YLESaafG91Uh@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b289fea8-e4c8-0fda-d637-daf5e85c66f6@sifive.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 02:08:45PM +0100, Ben Dooks wrote:
> On 31/05/2023 22:37, Bjorn Helgaas wrote:
> > On Wed, May 31, 2023 at 10:57:13AM +0100, Ben Dooks wrote:
> > > From: Ben Dooks <ben.dooks@sifive.com>
> > > 
> > > Add the define for PCI_EXT_CAP_ID_PL_32GT for drivers that
> > > will want this whilst doing Gen5/Gen6 accesses.
> > > 
> > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > I applied this to pci/enumeration for v6.5, thanks.
> > 
> > But I'm very curious about where you expect this to be used.
> 
> We have an upcoming driver that has gen5 phy and config requirements.

I guess a better question would have been whether
PCI_EXT_CAP_ID_PL_32GT is best used in individual drivers or in the
PCI core.  Since it's in the PCIe base spec and doesn't look like it
should be device-specific, it might be a candidate for supporting in
the PCI core somehow so it doesn't get reimplemented in several
places.

Bjorn
