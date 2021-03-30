Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3841E34EC1B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhC3PXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 11:23:07 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38218 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhC3PWx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 11:22:53 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D62EC92009C; Tue, 30 Mar 2021 17:22:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CEC7892009B;
        Tue, 30 Mar 2021 17:22:51 +0200 (CEST)
Date:   Tue, 30 Mar 2021 17:22:51 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     David Laight <David.Laight@ACULAB.COM>,
        'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Subject: Re: How long should be PCIe card in Warm Reset state?
In-Reply-To: <20210330150458.gzz44gczhraxc6bc@pali>
Message-ID: <alpine.DEB.2.21.2103301714450.18977@angie.orcam.me.uk>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali> <20210323161941.gim6msj3ruu3flnf@archlinux> <20210323162747.tscfovntsy7uk5bk@pali> <20210323165749.retjprjgdj7seoan@archlinux> <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
 <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk> <20210330131018.gby4ze3u6mii23ls@pali> <alpine.DEB.2.21.2103301628180.18977@angie.orcam.me.uk> <20210330150458.gzz44gczhraxc6bc@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Mar 2021, Pali Rohár wrote:

> >  The spec does not give any exceptions AFAICT as to the timeouts required 
> > between the three kinds of a Conventional Reset (Hot, Warm, or Cold) and 
> > refers to them collectively as a Conventional Reset across the relevant 
> > parts of the document, so clearly the same rules apply.
> 
> There are specified more timeouts related to Warm reset and PERST#
> signal. Just they are not in Base spec, but in CEM spec. See previous
> Amey's email where are described some timeouts and also links in my
> first email where I put other timeouts defined in specs relevant for
> PERST# signal and therefore also for Warm Reset.

 I specifically referred to the time allowed for devices to take between a 
reset and the first successful configuration cycle David wondered about.  
I don't think I can comment on the timeouts given in the CEM spec as I 
don't have a copy.  Sorry.

  Maciej
