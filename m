Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC83E3D0B3C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhGUIUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 04:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237454AbhGUIOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 04:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3116E6101E;
        Wed, 21 Jul 2021 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626857696;
        bh=kd+4dTdc2/L0vdJ20rKYVTfc7Q/zfKE6gLw9cC1PYtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWLz2Phc1fiyB0bLMX+hR88Rgg/HKiYl+O1AE0G5MWYJb9vhW5zQIOCwqdc9nYdDj
         3TPW1YCfTKcnWELCxXofDyVMsY4m4s6MVuyVpZIIa80/xnSrlHACctpiFLeL7Ip8os
         XUcEXwWtRfTZ2xQInRVlTy88UNLlVYUos2FW7wUTMwBJKpbJTs2rLZOKWGyJ39RGQ8
         RaC+ogT/QA0jM4rJQQ/xP4jzvq/emEmJojtKCIJOkaS71hl1cPpD7wS0fZ5wQXBVDP
         Nm/f+nKTEA+aJLymWlV+Zhy+Da+AtezBWzL5TT/WwDMGKFigyTEUz0PH06dFNgpdvm
         Jeo1pV9YtJsWQ==
Received: by pali.im (Postfix)
        id A6A8779B; Wed, 21 Jul 2021 10:54:53 +0200 (CEST)
Date:   Wed, 21 Jul 2021 10:54:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Ingmar Klein <ingmar_klein@web.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210721085453.aqd73h22j6clzcfs@pali>
References: <20210415195338.icpo5644bo76rzuc@pali>
 <20210525221215.GA1235899@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525221215.GA1235899@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 25 May 2021 17:12:15 Bjorn Helgaas wrote:
> On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Rohár wrote:
> > Hello!
> > 
> > On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
> > > [cc +Pali]
> > > 
> > > On Thu, 15 Apr 2021 20:02:23 +0200
> > > Ingmar Klein <ingmar_klein@web.de> wrote:
> > > 
> > > > First thanks to you both, Alex and Bjorn!
> > > > I am in no way an expert on this topic, so I have to fully rely on your
> > > > feedback, concerning this issue.
> > > > 
> > > > If you should have any other solution approach, in form of patch-set, I
> > > > would be glad to test it out. Just let me know, what you think might
> > > > make sense.
> > > > I will wait for your further feedback on the issue. In the meantime I
> > > > have my current workaround via quirk entry.
> > > > 
> > > > By the way, my layman's question:
> > > > Do you think, that the following topic might also apply for the QCA6174?
> > > > https://www.spinics.net/lists/linux-pci/msg106395.html
> > 
> > I have been testing more ath cards and I'm going to send a new version
> > of this patch with including more PCI ids.
> 
> Dropping this patch in favor of Pali's new version.

Hello Bjorn! Seems that it would take much more time to finish my
version of patch. So could you take Ingmar's patch with cc:stable tag
for now, which just adds PCI device id into list of problematic devices?
