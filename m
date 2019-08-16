Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C98FF10
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHPJcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:32:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHPJcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:32:53 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyYbH-0006LJ-A0; Fri, 16 Aug 2019 11:32:47 +0200
Date:   Fri, 16 Aug 2019 11:32:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Denis Efremov <efremov@linux.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] x86/PCI: Loop using PCI_STD_NUM_BARS
In-Reply-To: <20190816092437.31846-4-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.1908161131400.1873@nanos.tec.linutronix.de>
References: <20190816092437.31846-1-efremov@linux.com> <20190816092437.31846-4-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 16 Aug 2019, Denis Efremov wrote:

> Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
> 'i <= PCI_STD_RESOURCE_END'.

Please describe the WHY not the WHAT. I can see the WHAT from the patch
itself, but I can't figure out WHY.

Thanks,

	tglx
