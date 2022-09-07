Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21855AFBBC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 07:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIGF2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 01:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIGF2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 01:28:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E109D669;
        Tue,  6 Sep 2022 22:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662528511; x=1694064511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ni2b1or+WJl3f/muoxWtjXKY7nsRk57vd58SbzaLBVU=;
  b=G2izTTzF4mRYlptRSIl7qQYVtUKeYtdWGUQmYayC2PWPOPZSxABr6Aaa
   lsULVSBP3c+K4TX/zjjSfVsZoJjsFy3CjnldJgXdwjsZfVTw2nuWAYlvI
   4MrRXr/vbuiz/+ZPAYtXJFhCzjJk8/2o07cQM7C77OtLO9RgIoqm62uGI
   vnN0uC1fmAebNpQXC5xIy+jooGtnj/eaTSu4bCsCi6S3PfK/L+fH8MNJN
   z+2YNyvkX29mcSRyjmcXuXf9AVRB/fdQ5hIiWDSNyilSROVGrTOLB5RZF
   XP2/EeILyW23UhoP9tizeeOZgdSoxYT4AK3KaPywZhswH27N3yLKt41R5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298098915"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="298098915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="565373218"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 22:28:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 02BD6F7; Wed,  7 Sep 2022 08:28:43 +0300 (EEST)
Date:   Wed, 7 Sep 2022 08:28:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 05/10] PCI/PTM: Add pci_disable_ptm() wrapper
Message-ID: <YxgsCwOeFJVvItVO@black.fi.intel.com>
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-6-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906222351.64760-6-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 05:23:46PM -0500, Bjorn Helgaas wrote:
> @@ -42,6 +42,13 @@ void pci_disable_ptm(struct pci_dev *dev)
>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
>  }

Since you export these, I suggest adding kernel-doc to explain how these
are supposed to be used in drivers (pre-conditions etc.).

> +void pci_disable_ptm(struct pci_dev *dev)
> +{
> +	__pci_disable_ptm(dev);
> +	dev->ptm_enabled = 0;
> +}
> +EXPORT_SYMBOL(pci_disable_ptm);

EXPORT_SYMBOL_GPL()?
