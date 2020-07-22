Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150322A135
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGVVPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVVPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 17:15:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D88C0619DC;
        Wed, 22 Jul 2020 14:15:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595452509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wimSqbltrQnSesY3skr5Df0xojhTY8Yy4hyTLr3Fuak=;
        b=4dUVs2L5wtvRxvFTUwKajtdmrXdtuL/NWjtIeoL7448CUD01XrjZnzuegTHzm0kSUsp8X3
        89D/WUHrQqXRbLZcJU9q1ZQlKHB4G56oq1fFLqyfBfYzJeBXgt8s2mXGZPaLQfkcemRMZo
        kzSKJHKTItfux2t4/pPvS3wU87aJUiXkl3IMdYThkb7fbSldc6JYFrzECtu8IKaaFN1Jr1
        uceIz3uFl+PTnGOnZ98oA1kLBK9n9EDF2U7ma+74mv/1h0ZkN9SqRTPrJfdazzaGgv+dtH
        NCH8/ks6cVcKeBDyYaD5e1Ep8udG4/H6y660n/qjL03Um5Lj3EOzE6ytbvdyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595452509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wimSqbltrQnSesY3skr5Df0xojhTY8Yy4hyTLr3Fuak=;
        b=OPeSDaNTY1oms4EEQ9e2C7R0KptY3qCOSWgAj4fF9m9gcVMeBCoWhFC8lk4JeSvc4hEa/l
        R2tvWd4o+ZJaxmDQ==
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain/treewide: Free firmware node after domain removal
In-Reply-To: <1595363169-7157-1-git-send-email-jonathan.derrick@intel.com>
References: <1595363169-7157-1-git-send-email-jonathan.derrick@intel.com>
Date:   Wed, 22 Jul 2020 23:15:08 +0200
Message-ID: <87h7tzz1yb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jon Derrick <jonathan.derrick@intel.com> writes:
> Change 711419e504eb ("irqdomain: Add the missing assignment of
> domain->fwnode for named fwnode") unintentionally caused a dangling
> pointer page fault issue on firmware nodes that were freed after IRQ
> domain allocation. Change e3beca48a45b fixed that dangling pointer issue
> by only freeing the firmware node after an IRQ domain allocation
> failure. That fix no longer frees the firmware node immediately, but
> leaves the firmware node allocated after the domain is removed.

Gah, I missed that under the assumption that these nodes are freed when
the domain is removed. What a mess.

> We need to keep the firmware node through irq_domain_remove, but should
> free it afterwards. This patch saves the handle and adds the freeing of
> firmware node after domain removal where appropriate.

Care to read Documentation/process/submitting-patches.rst and look for
'I/We' and 'This patch' next time?

Thanks,

        tglx
