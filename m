Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2EDF548
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfJUSrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 14:47:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54124 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 14:47:14 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id EC5DD2006F6;
        Mon, 21 Oct 2019 18:47:12 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C897220552; Mon, 21 Oct 2019 20:47:01 +0200 (CEST)
Date:   Mon, 21 Oct 2019 20:47:01 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Michael ." <keltoiboy@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20191021184701.GA1823@light.dominikbrodowski.net>
References: <20191020090800.GA2778@light.dominikbrodowski.net>
 <20191021160952.GA229204@google.com>
 <CAFjuqNg2BjbxsOeOpoo8FQRwatQHeHKhj01hbwNrSHjz9p3vYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFjuqNg2BjbxsOeOpoo8FQRwatQHeHKhj01hbwNrSHjz9p3vYw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 05:17:12AM +1100, Michael . wrote:
> Thank you Dominik for looking at this for us and passing it on.
> 
> Good morning Bjorn, thank you also for looking into this for us and
> thank you for CCing us into this as non of us are on the mailing list.
> One question how do we apply this patch or is this for Dominik to try?

That's for you and/or other users of this hardware; I cannot test this
myself, sorry. As to how to apply the patch: you'd need to apply the patch
for the linux kernel sources, and then build a custom kernel. Some hints on
that (details depend on the distribtion):

	https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
	https://wiki.ubuntu.com/KernelTeam/GitKernelBuild
	https://wiki.archlinux.org/index.php/Kernels/Arch_Build_System
	https://kernelnewbies.org/KernelBuild

Best,
	Dominik
