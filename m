Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0328A3F3745
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 01:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhHTXW7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 19:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231657AbhHTXW6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 19:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B1361178;
        Fri, 20 Aug 2021 23:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629501740;
        bh=0jIqpgSQLEAkVLru6dVKloOo6f5MBblToHw2u8S/hYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTwyUYD3N0uh+3AwfSOBnrosqbXBGdYXZKWM8AL0CGsKSn1fFuTA3QOgGyAsV+ppH
         x4lGFTolLpahI6Oy91b9BrxXs7zK1YEpvGuZkeNU5q0ApxT+YsaAnVKO8RoFBnXwEG
         RzvMdfBuKFH83hIN3kff9TTrSiGpIXkr6PIzbaoZWEI0sTAhh7J9XhhBuZ2Udr1EXu
         C+C4fZLnVEi0u69mIFDHwS8R13aFRWqW3axrESGx8dw4dcYrFQWqV9KHQ0hVOrZh+i
         zBJ3u4oAIxLwfO0jG74RMduh2wGcfAiU9HSHbS8XAysz01q2wjJx4dqqWhcrkgx9S5
         UdBXdfl8jqXVA==
Received: by pali.im (Postfix)
        id 5261FB8A; Sat, 21 Aug 2021 01:22:17 +0200 (CEST)
Date:   Sat, 21 Aug 2021 01:22:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Ingmar Klein <ingmar_klein@web.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210820232217.vkx6x6dpxf73jjhs@pali>
References: <20210415195338.icpo5644bo76rzuc@pali>
 <20210525221215.GA1235899@bjorn-Precision-5520>
 <20210721085453.aqd73h22j6clzcfs@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210721085453.aqd73h22j6clzcfs@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 21 July 2021 10:54:53 Pali Rohár wrote:
> On Tuesday 25 May 2021 17:12:15 Bjorn Helgaas wrote:
> > On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Rohár wrote:
> > > Hello!
> > > 
> > > On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
> > > > [cc +Pali]
> > > > 
> > > > On Thu, 15 Apr 2021 20:02:23 +0200
> > > > Ingmar Klein <ingmar_klein@web.de> wrote:
> > > > 
> > > > > First thanks to you both, Alex and Bjorn!
> > > > > I am in no way an expert on this topic, so I have to fully rely on your
> > > > > feedback, concerning this issue.
> > > > > 
> > > > > If you should have any other solution approach, in form of patch-set, I
> > > > > would be glad to test it out. Just let me know, what you think might
> > > > > make sense.
> > > > > I will wait for your further feedback on the issue. In the meantime I
> > > > > have my current workaround via quirk entry.
> > > > > 
> > > > > By the way, my layman's question:
> > > > > Do you think, that the following topic might also apply for the QCA6174?
> > > > > https://www.spinics.net/lists/linux-pci/msg106395.html
> > > 
> > > I have been testing more ath cards and I'm going to send a new version
> > > of this patch with including more PCI ids.
> > 
> > Dropping this patch in favor of Pali's new version.
> 
> Hello Bjorn! Seems that it would take much more time to finish my
> version of patch. So could you take Ingmar's patch with cc:stable tag
> for now, which just adds PCI device id into list of problematic devices?

Ping, gentle reminder...
