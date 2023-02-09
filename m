Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B06914F9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBIX6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 18:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBIX6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 18:58:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D0856EFD;
        Thu,  9 Feb 2023 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675987081; x=1707523081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkJYuf0jWpTKa4n2923yHxY6IDw7yMU4CeB6S6tPBCA=;
  b=Q2KBX3v6AZTqrTLdfvQR8b0szW9MueB+ZsLcl7VxjITPoWE/VaqZ6+gW
   Pg9rGzUqjcpeIPqgXnFyehBTAY+Uq4JMB+hKrGVSPaOxAgfA7OTHvvqQu
   3nGPacw61A4ooXMrWXjTDDi+emu+D+yg/1D9Xgx6upmSUm9MxrB835me/
   cB2msMxDy/oNVrRH3dKsQo+62WBh+C1u1Rtuelw37O4Z7VUNCyh8+f7TA
   di3bh+7Y3hgkKP1UsyyGbTjUX9J4iVllBRPHfqJGzHeakjySSafEh+MnV
   /blPNM7QL77o82YBeEXOWAybS03W3fSdKe4F+pd6p0kRth/IWesGDXBp3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="392680584"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="392680584"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:58:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="841835195"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="841835195"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.39.135]) ([10.212.39.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:58:00 -0800
Message-ID: <68b40228-d2e6-c63c-751b-972bfea93f41@linux.intel.com>
Date:   Thu, 9 Feb 2023 16:57:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Xinghui Li <korantwork@gmail.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
References: <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
 <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
 <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
 <Y+V8O9kDH5ZXWdBF@kbusch-mbp.dhcp.thefacebook.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <Y+V8O9kDH5ZXWdBF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/9/2023 4:05 PM, Keith Busch wrote:
> On Tue, Feb 07, 2023 at 01:32:20PM -0700, Patel, Nirmal wrote:
>> On 2/6/2023 8:18 PM, Xinghui Li wrote:
>>> Keith Busch <kbusch@kernel.org> 于2023年2月7日周二 02:28写道：
>>>> I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec_count(vmd->dev)".
>>> For this situation, My speculation is that the PCIE nodes are
>>> over-mounted and not just because of the CPU to Drive ratio.
>>> We considered designing online nodes, because we were concerned that
>>> the IO of different chunk sizes would adapt to different MSI-X modes.
>>> I privately think that it may be logically complicated if programmatic
>>> judgments are made.
>> Also newer CPUs have more MSIx (128) which means we can still have
>> better performance without bypass. It would be better if user have
>> can chose module parameter based on their requirements. Thanks.
> So what? More vectors just pushes the threshold to when bypass becomes
> relevant, which is exactly why I suggested it. There has to be an empirical
> answer to when bypass beats muxing. Why do you want a user tunable if there's a
> verifiable and automated better choice?

Make sense about the automated choice. I am not sure what is the exact
tipping point. The commit message includes only two cases. one 1 drive
1 CPU and second 12 drives 6 CPU. Also performance gets worse from 8
drives to 12 drives.
One the previous comments also mentioned something about FIO changing
cpus_allowed; will there be an issue when VMD driver decides to bypass
the remapping during the boot up, but FIO job changes the cpu_allowed?

