Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789D844C16
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfFMTZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:25:47 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39321 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfFMTZr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 15:25:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1F0D93000094A;
        Thu, 13 Jun 2019 21:25:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E17A94CF7F; Thu, 13 Jun 2019 21:25:44 +0200 (CEST)
Date:   Thu, 13 Jun 2019 21:25:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@endlessm.com,
        nouveau <nouveau@lists.freedesktop.org>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>
Subject: Re: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
Message-ID: <20190613192544.jpz35sjtmnw25gox@wunner.de>
References: <20190613063514.15317-1-drake@endlessm.com>
 <CAKb7UvjAGtQrcgO=GE8JHuy=mgCtOr+eTinBVwekXGHiam1t1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvjAGtQrcgO=GE8JHuy=mgCtOr+eTinBVwekXGHiam1t1A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 09:15:31AM -0400, Ilia Mirkin wrote:
> On Thu, Jun 13, 2019 at 2:35 AM Daniel Drake <drake@endlessm.com> wrote:
> > Link: https://devtalk.nvidia.com/default/topic/1024022
> > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
> > Cc: Aaron Plattner <aplattner@nvidia.com>
> > Cc: Peter Wu <peter@lekensteyn.nl>
> > Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: Maik Freudenberg <hhfeuer@gmx.de>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Tested-by: Daniel Drake <drake@endlessm.com>

Daniel, if you submit a v2 to address Ilia's comments, please be sure
to add your Signed-off-by.  Thanks for taking care of mainlining this.

Kind regards,

Lukas
