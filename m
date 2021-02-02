Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872B30C71B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhBBRLG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 12:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237249AbhBBRJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 12:09:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EFAC64F87;
        Tue,  2 Feb 2021 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612285704;
        bh=kfjDlNIaVJazL4BD9E8JsEE9EWpuCPoncBB5XS/Gm2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxLU42pT9IwOohjuggI83EYkw9r2Bc/yogUTvaDI2B0sFVSf4QKMdcnkBTkGGSnJP
         gRYaHTSJOal1g8+732zORip149mzM3sPaKIjEbYEr3soKwrwiRAefIGiBI+rp+jiD7
         7SJ25kEfW02MTR6ZgfK7M7X+kGR8CoCjMaPPTs4M=
Date:   Tue, 2 Feb 2021 18:08:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Message-ID: <YBmHBaevmWRmyUTq@kroah.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
 <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBklScf1HPCVKQPf@kroah.com>
 <DM5PR12MB183515FF24DC1C306CDCD718DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBkst6PeVskpi4SO@kroah.com>
 <DM5PR12MB18352C83BFA6587910C922A7DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB18352C83BFA6587910C922A7DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 04:58:50PM +0000, Gustavo Pimentel wrote:
> On Tue, Feb 2, 2021 at 10:43:3, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Feb 02, 2021 at 10:38:29AM +0000, Gustavo Pimentel wrote:
> > > On Tue, Feb 2, 2021 at 10:11:21, Greg Kroah-Hartman 
> > > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Tue, Feb 02, 2021 at 08:51:10AM +0000, Gustavo Pimentel wrote:
> > > > > Just a kindly reminder.
> > > > 
> > > > reminder of what?
> > > 
> > > To review the patch set. I've done the requested modifications, but I 
> > > didn't get any feedback if this patch series is fine or it needs 
> > > something more to have an ACK.
> > 
> > I do not knwo, I don't see anything my my review queue, sorry.
> 
> I've resend the patch series. Let's see if appears now 😊
> 
> > 
> > > If some feedback was provided, please accept my apologies. My email 
> > > account was having some issues some time ago and I might not have 
> > > received some emails.
> > 
> > Check the archives please, that's what they are there for :)
> 
> I have just checked, there isn't any feedback besides yours and Arnd 
> Bergmann.

Did you incorporate our review?

greg k-h
