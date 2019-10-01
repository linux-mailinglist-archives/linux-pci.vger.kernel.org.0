Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACA0C42F1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfJAVtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfJAVtP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 17:49:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78382133F;
        Tue,  1 Oct 2019 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569966554;
        bh=3O9ytnipO3eaLjocEP/4hY0yll0ieUCxfn0NQMgCwso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZzEhv2Sb/gm84Co1ZG1Z8fWWpyF8VVT8b2wL4MClmWB1nY/RZ8MXJTfUiu/qY6JYM
         VS2fNnFciEoUobi/wnl151THzhqrqWUaGHY3uc9UwQLtDcpAyilH/jbHCRK6uMLH4U
         ViUoga04FvmfmF96/78thqs0YjY6xfihkZ1+pC8Q=
Date:   Tue, 1 Oct 2019 16:49:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Message-ID: <20191001214912.GA78523@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001100727.GJ42880@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 11:07:28AM +0100, Andrew Murray wrote:
> Hi Tom,
> 
> Thanks for the patch.
> 
> I'd suggest that you rename the subject of this series to "PCI: cadence: ..."
> to be consistent with the existing commit history, e.g. git log 
> --oneline drivers/pci/controller/pcie-cadence* - you'll also see that you
> don't need a full stop at the end, and you ought to also change the tense
> of the subject, e.g. Refactor driver to ...
> 
> See comments inline...

Andrew, thank you very much for your detailed and thoughtful reviews
here and elsewhere.  It is a huge help.

Bjorn
