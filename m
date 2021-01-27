Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465CB30608F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbhA0QGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 11:06:41 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:50095 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhA0QEd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 11:04:33 -0500
Received: from xps-7390.lan (mobile-166-172-191-81.mycingular.net [166.172.191.81])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4DQpLN5FStz1NJF;
        Wed, 27 Jan 2021 11:03:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1611763421; bh=WoxYksT779c0u5+fx6C9zWh5rRJepYdpiZLR/v25Xc0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=v+R/GDbmOBiOsUIuf+WqYjPYyXCmdatStecKsF+WaNqMFR07Mh2gj5E6/FAqUPzTB
         PXEYWR1BSUsM/DFl8oYBlNnBQ6PvGsccq4l3QcO9pJR4liNt4LnmR4QGDnj42P33ag
         vveYZ/jf0m0OXe0zatkE6GSi8dZyrGBqTLvjP4ZQ=
Date:   Wed, 27 Jan 2021 08:03:39 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
In-Reply-To: <20210127155023.GA2988674@bjorn-Precision-5520>
Message-ID: <8f5111f-3679-b4b6-f86f-71871424843@panix.com>
References: <20210127155023.GA2988674@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 27 Jan 2021, Bjorn Helgaas wrote:

> > Any new news on this? Disabling "tlp" (which just shifts the problem around
> > on my machine) shouldn't be a solution for this issue.
>
> Agreed; disabling "tlp" is a workaround but not a solution.

Actually, disabling "tlp" doesn't fix the issue; I'd tested this and if IIRC,
if I don't use tlp it doesn't prevent this from happening, it just shifts it
from breaking on hibernate cycles to suspend/resume cycles instead.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
