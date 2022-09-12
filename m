Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC65B5BAB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiILNx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILNx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 09:53:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800F183B5;
        Mon, 12 Sep 2022 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662990836; x=1694526836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbzt0lrmC7TaIMc8MXfMMR3pFAnIuI/01jw8aaqyKOk=;
  b=SqB3r34W90JF3iTTLbrtrD4f2bRu/wEQgRl3CksH3Yj6lum2sRjPWyLy
   cvQZCu6OdmFmWUmj7CJPw3J+KLccmGGwjMRayj3lEv1JbWFe80/gJE/jK
   3K95US+E34eLYpSX/cc1R9gEFiVWm1XHYQcFLApvr2RkNuCbEU2RuAJHc
   BnSueOk0Wf5Vg2pXnx9eCo5DppKIXv58ea7Eh9XfHnJRGF36kx6u5dksN
   WUJSW2qvY6js/WZm4M3KhkI8ziLS9yYf6BYlWh/iqKSqkAsrp3aUyERoG
   IXO9EzQQySbr0wM/HwAA72b7m1fr6R7naIH0INv8MBFoSmXrgGUZPR0/i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278259509"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="278259509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 06:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758400221"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Sep 2022 06:53:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 12 Sep 2022 16:53:53 +0300
Date:   Mon, 12 Sep 2022 16:53:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Receiver ID)
Message-ID: <Yx858docsDh/ARiL@kuha.fi.intel.com>
References: <ae28dabe-d339-b56d-4a8e-ce4291c9b836@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae28dabe-d339-b56d-4a8e-ce4291c9b836@molgen.mpg.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

On Mon, Sep 12, 2022 at 03:36:09PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, connect a Dell DA300
> to the only USB Type-C port on the left side (with a network cable connect),
> Linux logs the warnings below:

> [   18.895120] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes

This warning you already reported [1]. I will send a patch for this
once I'm sure I understand what's going on. I'm fairly sure I now know
what is causing that, but I will still run a few more tests to be
absolutely sure.

The warning is in any case not critical.

[1] https://lore.kernel.org/linux-usb/726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de/

-- 
heikki
