Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A936B059
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhDZJRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 05:17:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhDZJRy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Apr 2021 05:17:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619428632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqUPWBRW7dcyBkHbauWThRHHgWUOOQvO1Uu+iN5yK68=;
        b=tTKe1Io36372J78zAJTkogEekXloyDTd04KXmjW3chAJ+4xDXIBXsVpH+lXa9j7jtVLvPZ
        6Nz5eXai4+oxSL3lK0PXg20hWsNbRFjY+AQQbYohe1vMrWqykQh6auN6lWt9LOAvtSID1X
        aLZp8yG7SsRud4OpINKax/2DEF0XHoc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D045B17E;
        Mon, 26 Apr 2021 09:17:12 +0000 (UTC)
Message-ID: <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI
 devices
From:   Oliver Neukum <oneukum@suse.com>
To:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Date:   Mon, 26 Apr 2021 11:17:10 +0200
In-Reply-To: <20210424021631.1972022-2-rajatja@google.com>
References: <20210424021631.1972022-1-rajatja@google.com>
         <20210424021631.1972022-2-rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, den 23.04.2021, 19:16 -0700 schrieb Rajat Jain:
> Export the already available info, to the userspace via the
> device core, so that userspace can implement whatever policies it
> wants to, for external removable devices.

Hi,

is there a way to tell apart whether a device can undergo regular
surprise removal? Do we want that?

	Regards
		Oliver


