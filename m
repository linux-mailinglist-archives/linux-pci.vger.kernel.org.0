Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E945AA86
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhKWRwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 12:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238975AbhKWRwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 12:52:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E04360174;
        Tue, 23 Nov 2021 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637689735;
        bh=pzzlSCJjdpkheBKOkp72bp1PArvjM9Ss86yRCbZoIQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K4vou06+XZlhOBT8RcmBo2uHZuVef7Zt+u0n986gQgtUmuuNHIF25HOQJTzCq7UGV
         lnfu27GpREcVMtVySvrbc4y8eu/yUGI5uEX0Pn93s/CYxXkpDT+fPAbp7p8pTs/KBQ
         BzWBIrpX3r+pqcrEzy1csHKyKXKNdap6TkuvbuIg4RnTRhGWpOMwGieQEuInetEBc8
         F2/5IA11iTYapiXFMf6QdhRTlZU4qyUR0y5LGb+pqx7+LRwHaUf3QUOQdJ85lH8kkr
         eTd5QBXtk2ihepj85G1XZdDyGvaIayIorQYJAjuLosdGl88+q8B06tTzJ48o3CJ6Ar
         mPNsn2m9OmLXQ==
Date:   Tue, 23 Nov 2021 11:48:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 18/23] cxl/pci: Implement wait for media active
Message-ID: <20211123174853.GA2230542@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123160413.pprxwlhan2qypjtv@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 08:04:13AM -0800, Ben Widawsky wrote:
> On 21-11-23 11:09:34, Jonathan Cameron wrote:
> > On Mon, 22 Nov 2021 14:57:51 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > 
> > > On 21-11-22 17:03:35, Jonathan Cameron wrote:
> > > > On Fri, 19 Nov 2021 16:02:45 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >   
> > > > > CXL 2.0 8.1.3.8.2 defines "Memory_Active: When set,
> > > > > indicates that the CXL Range 1 memory is fully initialized
> > > > > and available for software use.  Must be set within Range 1.
> > > > > Memory_Active_Timeout of deassertion of  
> > ...
> > Ah, got it. Maybe Range 1: Memory Active timeout ?
> 
> I can, but this is just quoted from the spec. Would this be better:
> 
> The CXL Type 3 Memory Device Software Guide (Revision 1.0) describes the
> need to check media active before using HDM. CXL 2.0 8.1.3.8.2 states:
> 
>   Memory_Active: When set, indicates that the CXL Range 1 memory is
>   fully initialized and available for software use. Must be set within
>   Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
>   if CXL.mem HwInit Mode=1

That is some weird wording.  I stumbled over that, too.  I like the
quote format better, but I still don't know what it means.

That last piece ("Memory_Active_Timeout of deassertion ...") purports
to be a sentence, but is not.
