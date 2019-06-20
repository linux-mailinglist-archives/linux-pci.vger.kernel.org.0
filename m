Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB54C745
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfFTGLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 02:11:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57902 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFTGLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 02:11:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 948A668B05; Thu, 20 Jun 2019 08:10:38 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:10:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Drake <drake@endlessm.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-ide@vger.kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        alex.williamson@redhat.com, dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
Message-ID: <20190620061038.GA20564@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com> <20190620051333.2235-3-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620051333.2235-3-drake@endlessm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please give up on this route.  We will not accept messing the NVMe
driver for Intels fucked up chipsets that are so bad that even they
are not allowed to talk about it anymore.

The Linux NVMe driver will deal with NVMe as specified plus whatever
minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
device is completely out of scope and will not be accepted.
