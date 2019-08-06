Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4526F838EB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfHFSpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 14:45:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:6976 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFSpp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 14:45:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="373511109"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2019 11:45:44 -0700
Message-ID: <1565118415.2401.113.camel@intel.com>
Subject: Re: [RFC V1 RESEND 3/6] x86: Introduce the dynamic teardown function
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@linux.intel.com
Date:   Tue, 06 Aug 2019 12:06:55 -0700
In-Reply-To: <alpine.DEB.2.21.1906290959400.1802@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <1561162778-12669-4-git-send-email-megha.dey@linux.intel.com>
         <alpine.DEB.2.21.1906290959400.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2019-06-29 at 10:01 +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Fri, 21 Jun 2019, Megha Dey wrote:
> > 
> >  
> > +void default_teardown_msi_irqs_grp(struct pci_dev *dev, int
> > group_id)
> > +{
> > +	int i;
> > +	struct msi_desc *entry;
> > +
> > +	for_each_pci_msi_entry(entry, dev) {
> > +		if (entry->group_id == group_id && entry->irq) {
> > +			for (i = 0; i < entry->nvec_used; i++)
> > +				arch_teardown_msi_irq(entry->irq +
> > i);
> With proper group management this whole group_id muck goes away. You
> hand
> in a group and clean it up and if done right then you don't need a
> new
> interface at all simply because everything is group based.
> 

Yeah , with the new proposal, this will hopefully be much cleaner.

> Thanks,
> 
> 	tglx
