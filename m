Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4110391C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfKTLvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:51:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:53499 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfKTLvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 06:51:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 03:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215772771"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 03:51:27 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 13:51:27 +0200
Date:   Wed, 20 Nov 2019 13:51:27 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191120115127.GD11621@lahna.fi.intel.com>
References: <20191017121901.13699-1-kherbst@redhat.com>
 <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com>
 <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120112212.GA11621@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 01:22:16PM +0200, Mika Westerberg wrote:
>             If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 
>                 0x05))))
>             {

The OSYS comes from this (in DSDT):

                If (_OSI ("Windows 2009"))
                {
                    OSYS = 0x07D9
                }

                If (_OSI ("Windows 2012"))
                {
                    OSYS = 0x07DC
                }

                If (_OSI ("Windows 2013"))
                {
                    OSYS = 0x07DD
                }

                If (_OSI ("Windows 2015"))
                {
                    OSYS = 0x07DF
                }

So I guess this particular check tries to identify Windows 7 and older,
and Linux.

>                 If ((PIOF == Zero))
>                 {
>                     P0LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P0LT == 0x08))
>                         {
>                             Break
>                         }
> 
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
> 
>                     P0RM = One
>                     P0AP = 0x03
>                 }
>                 ElseIf ((PIOF == One))
>                 {
>                     P1LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P1LT == 0x08))
>                         {
>                             Break
>                         }
> 
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
> 
>                     P1RM = One
>                     P1AP = 0x03
>                 }
>                 ElseIf ((PIOF == 0x02))
>                 {
>                     P2LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P2LT == 0x08))
>                         {
>                             Break
>                         }
> 
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
> 
>                     P2RM = One
>                     P2AP = 0x03
>                 }
> 
>                 If ((PBGE != Zero))
>                 {
>                     If (SBDL (PIOF))
>                     {
>                         MBDL = GMXB (PIOF)
>                         PDUB (PIOF, MBDL)
>                     }
>                 }
>             }
>             Else
>             {
>                 LKDS (PIOF)
>             }
> 
>             If ((DerefOf (SCLK [Zero]) != Zero))
>             {
>                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
>                 Sleep (0x10)
>             }
> 
>             GPPR (PIOF, Zero)
>             If ((OSYS != 0x07D9))
>             {
>                 DIWK (PIOF)
>             }
> 
>             \_SB.SGOV (0x01010004, Zero)
>             Sleep (0x14)
>             Return (Zero)
>         }
