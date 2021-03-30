Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70E34EA79
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhC3Oe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhC3Oet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 10:34:49 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA95C061574;
        Tue, 30 Mar 2021 07:34:48 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8764492009C; Tue, 30 Mar 2021 16:34:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7FDA592009B;
        Tue, 30 Mar 2021 16:34:47 +0200 (CEST)
Date:   Tue, 30 Mar 2021 16:34:47 +0200 (CEST)
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
In-Reply-To: <20210330131018.gby4ze3u6mii23ls@pali>
Message-ID: <alpine.DEB.2.21.2103301628180.18977@angie.orcam.me.uk>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali> <20210323161941.gim6msj3ruu3flnf@archlinux> <20210323162747.tscfovntsy7uk5bk@pali> <20210323165749.retjprjgdj7seoan@archlinux> <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
 <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk> <20210330131018.gby4ze3u6mii23ls@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Mar 2021, Pali Rohár wrote:

> >  If I were to implement this stuff, for good measure I'd give it a safety 
> > margin beyond what the spec requires and use a timeout of say 2-4s while 
> > actively querying the status of the device.  The values given in the spec 
> > are only the minimum requirements.
> 
> Are you able to also figure out what is the minimal timeout value for 
> PCIe Warm Reset?
> 
> Because we are having troubles to "decode" correct minimal timeout value
> for this PCIe Warm Reset (not Function-level reset).

 The spec does not give any exceptions AFAICT as to the timeouts required 
between the three kinds of a Conventional Reset (Hot, Warm, or Cold) and 
refers to them collectively as a Conventional Reset across the relevant 
parts of the document, so clearly the same rules apply.

  Maciej
