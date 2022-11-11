Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9500625BCC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiKKN5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiKKN4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599B7F560;
        Fri, 11 Nov 2022 05:55:06 -0800 (PST)
Message-ID: <20221111122015.397739421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UuC1MepTqQIaLcqFkObf7DFyoADcBMPY/PEQtFoZlnk=;
        b=GthpV0+bUwZ0On/zDcLYLzsswb8L1Lyf03t32FEBRxX4PnOlz+khlP72rDfyiJ1x9wRgx0
        QZBHxxrL4JkPQLW7wxnFxQQP1C3bGSUtkFuYA7n7ImHn09T6nJKXmSRNq6GMcgez9zHcBr
        /sXuwxE+KMFFbdY6PdL0GaHWRYeq2JTEl73uUqyXZcW+aV/4sFTHIWAWRwSUxCox9LTE9G
        hYCMBp2pxhJCSf4Vrdt9VkoToU9NxPEz3oqd083h7hlHGv5jYqQ13ynW5aQ/L+OWRe7yr0
        HZqb6OTN06vPLw7H/xCHtuHUesG4QYeE53KYO3lB8wsG9XL+fgCEqmcpWHMg5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UuC1MepTqQIaLcqFkObf7DFyoADcBMPY/PEQtFoZlnk=;
        b=N5w5QY6eUkXGEGiXNQj1Q3SBpVNANVHkPj6Rf+UFoASB2T/i/8da2rW7Kz59cuUMxbBlwY
        9I6yIp/HKRYP4CAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 31/39] Documentation: PCI: Add reference to PCI/MSI device driver APIs
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 11 Nov 2022 14:55:04 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQWhtZWQgUy4gRGFyd2lzaCA8ZGFyd2lAbGludXRyb25peC5kZT4KCkFsbCBleHBvcnRl
ZCBkZXZpY2UtZHJpdmVyIE1TSSBBUElzIGFyZSBub3cgZ3JvdXBlZCBpbiBvbmUgcGxhY2UgYXQK
ZHJpdmVycy9wY2kvbXNpL2FwaS5jIHdpdGggY29tcHJlaGVuc2l2ZSBrZXJuZWwtZG9jcyBhZGRl
ZC4KClJlZmVyZW5jZSB0aGVzZSBrZXJuZWwtZG9jcyBpbiB0aGUgb2ZmaWNpYWwgUENJL01TSSBo
b3d0by4KClNpZ25lZC1vZmYtYnk6IEFobWVkIFMuIERhcndpc2ggPGRhcndpQGxpbnV0cm9uaXgu
ZGU+ClNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgoK
LS0tCiBEb2N1bWVudGF0aW9uL1BDSS9tc2ktaG93dG8ucnN0IHwgICAxMCArKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQotLS0KLS0tIGEvRG9jdW1lbnRhdGlvbi9Q
Q0kvbXNpLWhvd3RvLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL1BDSS9tc2ktaG93dG8ucnN0CkBA
IC0yODUsMyArMjg1LDEzIEBAIHRvIGJyaWRnZXMgYmV0d2VlbiB0aGUgUENJIHJvb3QgYW5kIHRo
ZQogSXQgaXMgYWxzbyB3b3J0aCBjaGVja2luZyB0aGUgZGV2aWNlIGRyaXZlciB0byBzZWUgd2hl
dGhlciBpdCBzdXBwb3J0cyBNU0lzLgogRm9yIGV4YW1wbGUsIGl0IG1heSBjb250YWluIGNhbGxz
IHRvIHBjaV9hbGxvY19pcnFfdmVjdG9ycygpIHdpdGggdGhlCiBQQ0lfSVJRX01TSSBvciBQQ0lf
SVJRX01TSVggZmxhZ3MuCisKKworTGlzdCBvZiBkZXZpY2UgZHJpdmVycyBNU0koLVgpIEFQSXMK
Kz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CisKK1RoZSBQQ0kvTVNJIHN1Ynlz
dGVtIGhhcyBhIGRlZGljYXRlZCBDIGZpbGUgZm9yIGl0cyBleHBvcnRlZCBkZXZpY2UgZHJpdmVy
CitBUElzIOKAlCBgZHJpdmVycy9wY2kvbXNpL2FwaS5jYC4gVGhlIGZvbGxvd2luZyBmdW5jdGlv
bnMgYXJlIGV4cG9ydGVkOgorCisuLiBrZXJuZWwtZG9jOjogZHJpdmVycy9wY2kvbXNpL2FwaS5j
CisgICA6ZXhwb3J0OgoK
