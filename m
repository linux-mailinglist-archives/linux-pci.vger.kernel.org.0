Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5207CE461
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGN4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 09:56:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfJGN4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 09:56:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF83142F;
        Mon,  7 Oct 2019 06:56:39 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117B93F703;
        Mon,  7 Oct 2019 06:56:38 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:56:37 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Message-ID: <20191007135636.GA42880@e119886-lin.cambridge.arm.com>
References: <20191001100727.GJ42880@e119886-lin.cambridge.arm.com>
 <20191001214912.GA78523@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001214912.GA78523@google.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 04:49:12PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2019 at 11:07:28AM +0100, Andrew Murray wrote:
> > Hi Tom,
> > 
> > Thanks for the patch.
> > 
> > I'd suggest that you rename the subject of this series to "PCI: cadence: ..."
> > to be consistent with the existing commit history, e.g. git log 
> > --oneline drivers/pci/controller/pcie-cadence* - you'll also see that you
> > don't need a full stop at the end, and you ought to also change the tense
> > of the subject, e.g. Refactor driver to ...
> > 
> > See comments inline...
> 
> Andrew, thank you very much for your detailed and thoughtful reviews
> here and elsewhere.  It is a huge help.
> 

Thanks no problem, it's a pleasure :)

Thanks,

Andrew Murray

> Bjorn
