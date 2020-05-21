Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781CF1DC907
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEUIwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 04:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgEUIwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 04:52:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C9720721;
        Thu, 21 May 2020 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590051133;
        bh=7HSD2FPYJhJw5LIUGQCKg0DiB/PRK/rRNeK7roKiAmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AA/ToOaZp9tGA5EJAmfgp1VQWs+0vnFWWFdfR+fBuPAvtaBUesm37kJ/932sU8Z16
         AK1O4lsJtQcV4a/eBmsN6CVuFblmEDWo2Fj+3VTc/OCatDKUN+Kqp3AKNARgLDnHWW
         CSXU7GE2ApYvkoMNawymzrbMFPDvK89yIA4LVrX0=
Date:   Thu, 21 May 2020 10:52:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: Possible bug in drivers/misc/cardreader/rtsx_pcr.c
Message-ID: <20200521085211.GA2732409@kroah.com>
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:04:06PM +0200, Klaus Doth wrote:
> Hi,
> 
> 
> As per the info from kernelnewbies IRC, I'm sending this also to the PCI
> list.

<snip>

Can you submit a proposed patch in a format that it can be tested and
possibly submitted in so that we can review this easier?

Also try cc:ing the author of changes in that code, Rui Feng
<rui_feng@realsil.com.cn>, as well, as they are the best one to review
and comment on your issue.

thanks,

greg k-h
