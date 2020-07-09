Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67621A7BB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 21:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGITY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 15:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGITY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 15:24:57 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B00320775;
        Thu,  9 Jul 2020 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594322697;
        bh=8WabetCgwVG9DllPtJNp//ALDfDm8n6ryWtUjpDnK0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=li8p8+EzZG8tGvGkw6YvDyone1lKT93akiLXJnhWtlABghzZKxX8MGMWnVbG/AIy7
         EFZqMUO+IitTkLdaNcljnFLB1lKu08c6NwkOaZDCIbor0ndZBfg3sFUiuW3nU449W7
         5VnfozvoV8wpqnP2zi4K+5yJSgT10GauwUXj9hBM=
Date:   Thu, 9 Jul 2020 14:24:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manish Raturi <raturi.manish@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Dump of registers during endpoint link down
Message-ID: <20200709192455.GA12154@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn-FMy0i=c6jj_yvtQXrKMU5T8F+2AUd79qUw7U98vs9U35hA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 12:44:24PM +0530, Manish Raturi wrote:
> Hi Team,
> 
> I have a generic query , if an hotplug pcie endpoint connected to the
> CPU root port shows link down, then from the debugging perspective
> w.r.t PCIE what all register can be dump during the failure condition,
> what I can think of is these registers from the root port side
> 
> 1) Link status /control/capability
> 2) Slot status /control/capability
> 3) Lane error status registers.
> 
> Anything else we can dump which gives us more insight into the issue.
> Also is there anything by which we can check from PCIE clock
> perspective.

If you have this:

  Root Port ----- Endpoint

and the Link is down, you won't be able to read any registers from the
Endpoint.  You can dump all the Root Port registers, of course, e.g.,
with "lspci -vvvxxxx".
