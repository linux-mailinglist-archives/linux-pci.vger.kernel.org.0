Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2E42DAA2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNNn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNNn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 09:43:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD48C061570;
        Thu, 14 Oct 2021 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yh0dLNTCAidxPky1fKSiNS/T1k0UpRDN2U2Pf55bD6Q=; b=RYuW1teOpHoxKXuAE0m9w30T5o
        piZKigjQ0cg4nSULeNxiuEVSgvHKRyIj/BI7eg/iiljIgrU1oQ/KeZAnRvRq8rFI1Wxg2SkO1pqtZ
        klOcoquqJszlE2YOh9GXH9V6b+HSCpr3WeaSONyri9Nj8KEtDaOJAyX7xZ068gMFQ4AwTVpdbxcaR
        zBOk5ISSuBfqfv7nv/GX65Zd3nqgKOkhoEA83T2o+EQeRS+kVuQAXfSByZH97ZkcSB7jbAdaktL28
        Vro+JsZT85iieaduwkauV9g1Fa7/HpCnN2+jJNKn6w28uV0rP5XE/etmAmJO59Ah/+9XrahTKqPT2
        rA4kvFvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb0yf-003Hyo-PY; Thu, 14 Oct 2021 13:40:57 +0000
Date:   Thu, 14 Oct 2021 06:40:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
Message-ID: <YWgzaa9Z4elzoRwL@infradead.org>
References: <20211014110357.17957-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014110357.17957-1-hdegoede@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
> +	 * Some BIOS-es contain a bug where they add addresses which map to system
> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method,

Please avoid the overly long lines in your comments.
