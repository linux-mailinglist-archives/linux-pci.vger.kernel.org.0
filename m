Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0FF23FD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 02:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKGBHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 20:07:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:39135 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKGBHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 20:07:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xA715jlv031273;
        Wed, 6 Nov 2019 19:05:46 -0600
Message-ID: <50469ff0f7f7fb8513bf4daed018c2d96503e27a.camel@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Wed, 06 Nov 2019 17:05:45 -0800
In-Reply-To: <20191106232405.GA242013@google.com>
References: <20191106232405.GA242013@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-11-06 at 17:24 -0600, Bjorn Helgaas wrote:
> [+cc Ben]

Note: I'm travelling this week, I'll try to have a look in the next few
days but can't promise.

Cheers,
Ben.

