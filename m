Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365809D7F5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfHZVNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 17:13:48 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51554 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHZVNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 17:13:48 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 17:13:45 EDT
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 50E9C2000A;
        Tue, 27 Aug 2019 00:05:48 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 955DE36C0F6; Tue, 27 Aug 2019 00:05:47 +0300 (EEST)
Date:   Tue, 27 Aug 2019 00:05:47 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        George Dunlap <George.Dunlap@citrix.com>,
        Jan Beulich <JBeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?iso-8859-1?Q?H=E5kon?= Alstadheim <hakon@alstadheim.priv.no>
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
Message-ID: <20190826210547.GE2840@reaktio.net>
References: <5A377E020200007800197FFA@prv-mh.provo.novell.com>
 <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
 <20180916114306.GF18222@reaktio.net>
 <a726840b-8a5c-0890-73c6-3a95a7205153@oracle.com>
 <20180918071519.GG18222@reaktio.net>
 <5E7DDB68-4E68-48A5-AEEC-EE1B21A50E9E@citrix.com>
 <352310b3-ec9b-2ceb-83f0-4550718120c3@oracle.com>
 <20180919090526.s3ahnemrt2ik2tx3@mac.bytemobile.com>
 <20181003155104.GH5318@reaktio.net>
 <f6b8e055-7afc-b4de-af88-425d799dcd28@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b8e055-7afc-b4de-af88-425d799dcd28@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Oct 08, 2018 at 10:32:45AM -0400, Boris Ostrovsky wrote:
> On 10/3/18 11:51 AM, Pasi Kärkkäinen wrote:
> > On Wed, Sep 19, 2018 at 11:05:26AM +0200, Roger Pau Monné wrote:
> >> On Tue, Sep 18, 2018 at 02:09:53PM -0400, Boris Ostrovsky wrote:
> >>> On 9/18/18 5:32 AM, George Dunlap wrote:
> >>>>> On Sep 18, 2018, at 8:15 AM, Pasi Kärkkäinen <pasik@iki.fi> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On Mon, Sep 17, 2018 at 02:06:02PM -0400, Boris Ostrovsky wrote:
> >>>>>> What about the toolstack changes? Have they been accepted? I vaguely
> >>>>>> recall there was a discussion about those changes but don't remember how
> >>>>>> it ended.
> >>>>>>
> >>>>> I don't think toolstack/libxl patch has been applied yet either.
> >>>>>
> >>>>>
> >>>>> "[PATCH V1 0/1] Xen/Tools: PCI reset using 'reset' SysFS attribute":
> >>>>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00664.html
> >>>>>
> >>>>> "[PATCH V1 1/1] Xen/libxl: Perform PCI reset using 'reset' SysFS attribute":
> >>>>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00663.html
> >>>
> >>> Will this patch work for *BSD? Roger?
> >> At least FreeBSD don't support pci-passthrough, so none of this works
> >> ATM. There's no sysfs on BSD, so much of what's in libxl_pci.c will
> >> have to be moved to libxl_linux.c when BSD support is added.
> >>
> > Ok. That sounds like it's OK for the initial pci 'reset' implementation in xl/libxl to be linux-only.. 
> >
> 
> Are these two patches still needed? ISTR they were  written originally
> to deal with guest trying to use device that was previously assigned to
> another guest. But pcistub_put_pci_dev() calls
> __pci_reset_function_locked() which first tries FLR, and it looks like
> it was added relatively recently.
> 

Replying to an old thread.. I only now realized I forgot to reply to this message earlier.

afaik these patches are still needed. Håkon (CC'd) wrote to me in private that
he gets a (dom0) Linux kernel crash if he doesn't have these patches applied.


Here are the links to both the linux kernel and libxl patches:


"[Xen-devel] [PATCH V3 0/2] Xen/PCIback: PCI reset using 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00659.html

[Note that PATCH V3 1/2 "Drivers/PCI: Export pcie_has_flr() interface" is already applied in upstream linux kernel, so it's not needed anymore]

"[Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus reset with 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00661.html


"[Xen-devel] [PATCH V1 0/1] Xen/Tools: PCI reset using 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00664.html

"[Xen-devel] [PATCH V1 1/1] Xen/libxl: Perform PCI reset using 'reset' SysFS attribute":
https://lists.xen.org/archives/html/xen-devel/2017-12/msg00663.html


> 
> -boris


Thanks,

-- Pasi

