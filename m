Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277A811888B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLJMeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 07:34:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:31868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfLJMeM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 07:34:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 04:34:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="220214100"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 10 Dec 2019 04:34:09 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 10 Dec 2019 14:34:08 +0200
Date:   Tue, 10 Dec 2019 14:34:08 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux v5.5 serious PCI bug
Message-ID: <20191210123408.GD2665@lahna.fi.intel.com>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210072800.GY2665@lahna.fi.intel.com>
 <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 12:00:23PM +0000, Nicholas Johnson wrote:
> The following is the culprit responsible for the issues:
> 
> commit 586bc4aab878efcf672536f0cdec3d04b6990c94
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Fri Nov 22 16:43:50 2019 -0500
> 
>     ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
>
> It is playing with PCI devices. Clearly they did not consider 
> hot-removal. I am guessing it is seeing the audio PCI func of the AMD 
> card in that Thunderbolt eGPU enclosure.
>
> I will collect information, make a bugzilla report and contact the AMD 
> team. If anybody wants to be cc'd in then let me know. Sorry for 
> bothering you and Bjorn with something which actually has nothing 
> directly to do with the PCI subsystem or Thunderbolt.

No problem. Thanks for taking time to bisect the issue.
