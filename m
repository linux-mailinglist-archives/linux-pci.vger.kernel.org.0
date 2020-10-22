Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB62961BE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368662AbgJVPhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 11:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368660AbgJVPhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 11:37:53 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3872463D;
        Thu, 22 Oct 2020 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603381073;
        bh=uPaF1r+32uicP8P83cuSfWMAglDZBepM1O6/jnk56II=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IUKPemNVFH0djshP1sj+uUZ8WeelqvjmREgqtTdLj/3hprIRZLuEW0izNxeatQR9E
         o1qd7+d4MfJIL64dAUwOHxrQOTVlIJvTb10fT9frLrY10i1V3zpxEMJcLeNSsD9+MD
         6EHalyjEWT1jb7id8H/8mtGFFTAPHo/OBx7o5ezo=
Date:   Thu, 22 Oct 2020 10:37:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20201022153750.GA503849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZufMEAieVgzxdPrbCzaPV0eM_NYX7idWkLVxQaJrYjC+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 18, 2020 at 01:35:27PM +0200, Ian Kumlien wrote:
> On Sat, Oct 17, 2020 at 12:41 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > On Fri, Oct 16, 2020 at 11:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > Can you please, please, collect these on your system, Ian?  I assume
> > > that you can easily collect it once without your patch, when you see
> > > poor I211 NIC performance but the system is otherwise working.  And
> > > you can collect it again *with* your patch.  Same Kconfig, same
> > > *everything* except adding your patch.
> >
> > Yeah I can do that, but I would like the changes output from the
> > latest patch suggestion
> > running on Kai-Heng's system so we can actually see what it does...
> 
> Is:
> https://bugzilla.kernel.org/show_bug.cgi?id=209725

That's a great start.  Can you attach the patch to the bugzilla too,
please, so it is self-contained?

And also the analysis of the path from Root Port to Endpoint, with the
exit latencies of each link, the acceptable latency of the endpoint
and

  (1) the computation done by the existing code that results in
  "latency < acceptable" that means we can enable ASPM, and

  (2) the correct computation per spec that results in
  "latency > acceptable" so we cannot enable ASPM?

This analysis will be the core of the commit log, and the bugzilla
with lspci info is the supporting evidence.

Bjorn
