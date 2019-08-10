Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D178288C74
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfHJRYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 13:24:13 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50787 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfHJRYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Aug 2019 13:24:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EEC4C325;
        Sat, 10 Aug 2019 13:24:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 10 Aug 2019 13:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=bjctkxe8oRYYpCugXJ+wcl/9Lro
        YPX45X0BOBMBQ9nA=; b=HOk4+kCGGOOqPckePyU/gx+yziDrnq1GfiYgSBUL2oi
        H0FvkhAo1ruPprmlw+PJs7y24A0qsUNLouxOmOo3yN9NG0uyyrYkZvvWJ7hsjCSQ
        DFnucWYou/pKJvQ2JvkP2FMnruYvPZgGJEi5cH0UM0SAq4FL43p5tZEyWyE8bimk
        pTR35Z+CwjKBCnogJ10XJILPnnAQOUIvN+YUdhuA7UplafuYYte+Q+VoerNjL004
        9dGuO/+cndy/W/s+gp93IvCwgEvfpUqUzeLAzFIJKUkkx/OjDbS9u+nZCSAdxOWb
        6QXnHSyn5z+5rVAPiZ8a5THzZf3nZPeWICRu0slngkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bjctkx
        e8oRYYpCugXJ+wcl/9LroYPX45X0BOBMBQ9nA=; b=inTQoiR0szCgBETOR26EYh
        VViLEjBiQbDutokQl+GJbgqnDqJ6bOaAHHow30GlHmEzD7abxdJBosFyY/TT6Zcg
        JssEM9me2WLMmEViRc8uKanAJpQUqQrdJ1cPtklVsOLusejry9KrQhe+B0uj6ges
        QgrUfghZvRdltZxSF9p+cyjelVWOo2G8Ec0aUeKpB8jyxKc6LyBtMwR10WTzeqte
        q0sT/wNpCpZUwGIk/dSV1z46s3A4X7BstSPU/Z1gtnJX+jRhjX3bTw7YWFJpkTkh
        Ws5VBMxvdG6qe0Y0cRYFL4wHID6/XRU2iUe0kHELf+RwHCkN3A3oWxaBe/Aij0Sw
        ==
X-ME-Sender: <xms:u_1OXQbWUkPRH6keGMfOtvTFembTLKS6NgP4Hs68H_86f8vDRXY2dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:u_1OXS9kj1PsMctPwlQooA0q8Xqc1hCkkkJqEwy5mk4yWGVa6EQ9YQ>
    <xmx:u_1OXSj_myn5EBoqwBab_1AQjTfWjPfVUoQNLlugMbQfmqHbtWZBXQ>
    <xmx:u_1OXakbvFQDs9uhgBT2evlyazJBne_yyAuFjAz2Yi-ssiupOG48gA>
    <xmx:u_1OXTdXqKzyvwTZvZa6lpsKU0N61Q5XBxReaGPWq1rpDbUHHyjvBw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id DCC9F380076;
        Sat, 10 Aug 2019 13:24:10 -0400 (EDT)
Date:   Sat, 10 Aug 2019 19:24:09 +0200
From:   Greg KH <greg@kroah.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Move sysfs SR-IOV
 functions to iov.c
Message-ID: <20190810172409.GB4482@kroah.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190810071719.GA16356@kroah.com>
 <20190810171525.GG221706@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810171525.GG221706@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 10, 2019 at 12:15:25PM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 10, 2019 at 09:17:19AM +0200, Greg KH wrote:
> > On Fri, Aug 09, 2019 at 01:57:21PM -0600, Kelsey Skunberg wrote:
> > > +static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> > 
> > DEVICE_ATTR_RO() please.  This is a device attribute, not a "raw"
> > kobject attribute.
> 
> This patch is just a move; here's the source of the line above:
> 
> > > -static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> 
> I certainly support using DEVICE_ATTR_RO() instead of __ATTR_RO(), but
> that should be down with a separate patch so it's not buried in what
> is otherwise a simple move.
> 
> > > +static struct device_attribute sriov_numvfs_attr =
> > > +		__ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > +		       sriov_numvfs_show, sriov_numvfs_store);
> > > +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> > > +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> > > +static struct device_attribute sriov_vf_device_attr =
> > > +		__ATTR_RO(sriov_vf_device);
> > > +static struct device_attribute sriov_drivers_autoprobe_attr =
> > > +		__ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > +		       sriov_drivers_autoprobe_show,
> > > +		       sriov_drivers_autoprobe_store);
> > 
> > Same for all of these, they should use DEVICE_ATTR* macros.
> > 
> > And why the odd permissions on 2 of these files?  Are you sure about
> > that?
> 
> Same for these.  It'd be nice to fix them (and similar cases in
> pci-sysfs.c, rpadlpar_sysfs.c, sgi_hotplug.c, slot.c) but in a
> separate patch.
> 
> I think Kelsey did the right thing here by not mixing unrelated fixes
> in with the code move.  A couple additional patches to change the
> __ATTR() uses and the permissions (git grep "\<S_" finds several
> possibilities) would be icing on the cake, but getting the SR-IOV
> code all together is an improvement by itself.

Ah, ok, that makes more sense.  As long as this is patch 1/X, I'm fine
with it :)

thanks,

greg k-h
