Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450144ED4E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFUQml convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 21 Jun 2019 12:42:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUQml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 12:42:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heMcN-0001HE-Lk; Fri, 21 Jun 2019 18:42:27 +0200
Date:   Fri, 21 Jun 2019 18:42:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kirr@nexedi.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@01.org
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Message-ID: <20190621164227.grpezgtzlz2egzr2@linutronix.de>
References: <alpine.DEB.2.20.1906191227430.3726@hadrien>
 <20190619162713.GA19859@deco.navytux.spb.ru>
 <20190619201859.GA197717@google.com>
 <e6568b7107d4cbef639f82a400ba8b1a@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e6568b7107d4cbef639f82a400ba8b1a@nexedi.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-06-20 07:01:43 [+0000], kirr@nexedi.com wrote:
> I meant just that it was ok to pick this change into 5.0-RT tree as
> kbuild robot was suggesting. Sorry for not being clear.

Okay, I was under the impression that this affect non-RT as well. But if
this is RT-only then let me pick it up…

> Kirill

Sebastian
