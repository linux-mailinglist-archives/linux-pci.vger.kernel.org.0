Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D66E95C2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDTNX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTNX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 09:23:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD149C6;
        Thu, 20 Apr 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681997037; x=1713533037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eXHBNoWZ5C9eV7iYDdSPHHBQ/JfwKX3mi1xRWHKRXU=;
  b=IGMttZa/xtUGHJBSXuwiwBKjn7f1rVQmyptWnGEdpzM2peLwBDN71O40
   lwBnghTtCvVNMohAq6UgJxsj0ga73EwFulYIWSkzeox1wjQpgjh1nb8k3
   t1U1aGXc4NNW60RKuvEo5c/hwWIiCeV6opRKDxBl+7WtuTFzNCz/25p0x
   k0Mn6E1hJ5tF91r3/RshDO41n3u2DIxHyxtD7sNLTPr3wb4XhUueUnoW1
   P17oZRl9S3A9nU0MHteT2CVM0l48XukaCCf3tUXCH/o7rhKZrRDlCy1fx
   KoDDEtIkzn0itBKvj5/XGsSjHE7qxhIzc5f0kL1ahZi7+56lEMdZoUvNr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344484509"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344484509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 06:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="756505113"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="756505113"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2023 06:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3C0261670; Thu, 20 Apr 2023 16:23:59 +0300 (EEST)
Date:   Thu, 20 Apr 2023 16:23:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/AER: Factor out interrupt toggling into
 helpers
Message-ID: <20230420132359.GQ66750@black.fi.intel.com>
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <20230420125941.333675-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420125941.333675-2-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 08:59:38PM +0800, Kai-Heng Feng wrote:
> There are many places that enable and disable AER interrput, so move
> them into helpers.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
