Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3B70FB46
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjEXQCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjEXQC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 12:02:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F01BD;
        Wed, 24 May 2023 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684944074; x=1716480074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wx0Ob/xebu07nSB9TJ+GF90jaV0TCKSH0UQ2GQEg59o=;
  b=RETM/931CbERbzpPgwOiAxqENRCG6p7YFd+3qZK3xafr2DYmDHgCYLWa
   0GDfBegkWSZ35HQmC+hp1f740bFgVV8JA5yQjIqIyD+wDXFOyxiGjPprV
   W/Bz5TQYN4iqxGY3igo6Pvf8OuG7EmivcnaLJ5/PkwFJ0mLwS7VU1RDpX
   J5a7zx613HNYITxTngezU0hqENZVtNsUd0Ehzk2z9qgxJILJBhLT3vho8
   Uld5PPSQPIAQY4H4/rwIDJwuzul+TG2rBfVIGttw6pRcrAttVXuR9+YzO
   g3VZkFLtza/k5iwl/RhEq955M0XZfmymdJXJXx8hd5X6rw5ZP3RmVF2NF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="343073976"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="343073976"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 08:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="654853056"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="654853056"
Received: from kknopp-mobl1.amr.corp.intel.com (HELO [10.212.186.147]) ([10.212.186.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 08:59:44 -0700
Message-ID: <571c2a4a-4832-e64e-4f3c-8e7c8a795579@intel.com>
Date:   Wed, 24 May 2023 09:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230503131656.15928-1-mheyne@amazon.de>
 <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
 <c0f7cf97-f7ea-83f2-3a9c-f77f82dfb689@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c0f7cf97-f7ea-83f2-3a9c-f77f82dfb689@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/24/23 08:47, Juergen Gross wrote:
>> Any other feedback on this one? This is definitely a bug but I
>> understand that
>> there might be different ways to fix it.
> 
> I'd be happy to take the patch via the Xen tree, but I think x86
> maintainers should at least ack that.

Ack.

Works for me.
