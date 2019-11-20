Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33961103B55
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfKTN0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 08:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKTN0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 08:26:35 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BE5224F3;
        Wed, 20 Nov 2019 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256394;
        bh=DsDYSq/DHhqcdU7x2gyp7R8L2zInP4Q/+ZwnP14xfC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FIpUZW/KMEsdAr5Fm7S9pIXa746/f8Kgf29oYt4vjombJ0MJRjGbemJJlubK/KWoi
         WypaXCzNSSCcJypzI/5gFfbJKMGuBSYgTG1qL/ZdnU5W2CFaMheI4C/Ic/oRSA5qEB
         4Mu5JBq6dNUdYxiFeG9vDQJLutf59sizvVKdNICo=
Date:   Wed, 20 Nov 2019 07:26:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / QoS: Wrap documentation to fit in 80 columns
Message-ID: <20191120132633.GA87581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzspKm_Zy8JzWC54iPfJKU=2Hx_FzP-vLBS=CreyKgbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 12:18:16PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 19, 2019 at 3:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Wrap to 80 columns.  No textual change except to correct some "it's" that
> > should be "its".
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied for 5.5, but I've dropped the "QoS" part from the subject, as
> this is not only about QoS.

Thank you!  Can't remember why I included "QoS" because it doesn't
make any sense.
