Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE470FAAE
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjEXPqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjEXPqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 11:46:34 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B06197;
        Wed, 24 May 2023 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1684943166; x=1716479166;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=9/BFiR9WjSZPq/EuaxN0jvRDDD5ugdAe5QjD82M1rfs=;
  b=O60Pvw1Ek6Uc10Ipb9KQ79aWuq4fhWNZnxvG/TA6keMjY6rZEKG58zin
   jhZNVQ3WD3ZuP5m5nMZyOEuXl2cUjx+7WFm6en8ds/al8JxM/90CstFEg
   Xtyugw71+2TUoh5Bv0al6L3T4W184TVCJ7BZFLpavhmRcKZ3qRIH1G3Jf
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,189,1681171200"; 
   d="scan'208";a="335305194"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 15:43:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id C180AE4889;
        Wed, 24 May 2023 15:43:31 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 15:43:31 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 15:43:31 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id C18DD964; Wed, 24 May 2023 15:43:30 +0000 (UTC)
Date:   Wed, 24 May 2023 15:43:30 +0000
From:   Maximilian Heyne <mheyne@amazon.de>
To:     Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ashok Raj <ashok.raj@intel.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
Message-ID: <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
References: <20230503131656.15928-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230503131656.15928-1-mheyne@amazon.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 03, 2023 at 01:16:53PM +0000, Maximilian Heyne wrote:
> Commit bf5e758f02fc ("genirq/msi: Simplify sysfs handling") reworked the
> creation of sysfs entries for MSI IRQs. The creation used to be in
> msi_domain_alloc_irqs_descs_locked after calling ops->domain_alloc_irqs.
> Then it moved into __msi_domain_alloc_irqs which is an implementation of
> domain_alloc_irqs. However, Xen comes with the only other implementation
> of domain_alloc_irqs and hence doesn't run the sysfs population code
> anymore.
> 
> Commit 6c796996ee70 ("x86/pci/xen: Fixup fallout from the PCI/MSI
> overhaul") set the flag MSI_FLAG_DEV_SYSFS for the xen msi_domain_info
> but that doesn't actually have an effect because Xen uses it's own
> domain_alloc_irqs implementation.
> 
> Fix this by making use of the fallback functions for sysfs population.
> 
> Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>


Any other feedback on this one? This is definitely a bug but I understand that
there might be different ways to fix it.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



