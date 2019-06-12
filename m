Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7953C44791
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfFMRAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 13:00:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:49157 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbfFLX6k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 19:58:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CNwO9h016775;
        Wed, 12 Jun 2019 18:58:25 -0500
Message-ID: <4ba4cc02ef0a30705fded5f2a66965c1f0f1b8ab.camel@kernel.crashing.org>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 13 Jun 2019 09:58:24 +1000
In-Reply-To: <20190612132730.GB13533@google.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
         <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
         <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
         <20190611233908.GA13533@google.com>
         <97fd2516fdde7f9f01688af426c103806f68dd2c.camel@kernel.crashing.org>
         <20190612132730.GB13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-12 at 08:27 -0500, Bjorn Helgaas wrote:
> Speaking of which, *this* patch looks like FUD because it essentially
> says "Linux shouldn't change the PCI configuration on this system" but
> it offers no explanation of *why* the config needs to be preserved.  I
> would really like some note like "run-time firmware depends on the
> addresses of device X".

BTW. the patch doesn't say that. ACPI tells us that :-)

Cheers
Ben.


