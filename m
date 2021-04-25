Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBF36A7DA
	for <lists+linux-pci@lfdr.de>; Sun, 25 Apr 2021 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhDYO7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Apr 2021 10:59:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54185 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230244AbhDYO7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Apr 2021 10:59:35 -0400
Received: (qmail 337276 invoked by uid 1000); 25 Apr 2021 10:58:54 -0400
Date:   Sun, 25 Apr 2021 10:58:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v2 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <20210425145854.GD336783@rowland.harvard.edu>
References: <20210424021631.1972022-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424021631.1972022-1-rajatja@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 23, 2021 at 07:16:30PM -0700, Rajat Jain wrote:
> Move the "removable" attribute from USB to core in order to allow
> it to be supported by other subsystem / buses. Individual buses
> that want to support this attribute can opt-in by setting the
> supports_removable flag, and then populating the removable property
> of the device while enumerating it. The ABI for the attribute remains
> unchanged.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: Add documentation

For the parts affecting the USB core:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
