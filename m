Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D4830BC46
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 11:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBBKnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 05:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBBKns (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 05:43:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB96964D9C;
        Tue,  2 Feb 2021 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612262588;
        bh=AXiLBCX4n0vbr8s5sfDetV4X7CBLkBwH6/ojo3pJa0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqtzCAZDObcLN6afz7F2F5pUMS+PIzr9V0HmAM5K4vReRqex4DdiH7goYlYF4gc6q
         gWS+xDI4PaAh/86v6cUHYKYIjUKUTEgEAiNR68ncPADtyW3thQwaRzN4qTlSZ3ieWL
         haaBS6ziDVRFPIK+fY1VF5Pekn1ld13KdXIutZvI=
Date:   Tue, 2 Feb 2021 11:43:03 +0100
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
Message-ID: <YBkst6PeVskpi4SO@kroah.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
 <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBklScf1HPCVKQPf@kroah.com>
 <DM5PR12MB183515FF24DC1C306CDCD718DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB183515FF24DC1C306CDCD718DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 10:38:29AM +0000, Gustavo Pimentel wrote:
> On Tue, Feb 2, 2021 at 10:11:21, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Feb 02, 2021 at 08:51:10AM +0000, Gustavo Pimentel wrote:
> > > Just a kindly reminder.
> > 
> > reminder of what?
> 
> To review the patch set. I've done the requested modifications, but I 
> didn't get any feedback if this patch series is fine or it needs 
> something more to have an ACK.

I do not knwo, I don't see anything my my review queue, sorry.

> If some feedback was provided, please accept my apologies. My email 
> account was having some issues some time ago and I might not have 
> received some emails.

Check the archives please, that's what they are there for :)

greg k-h
