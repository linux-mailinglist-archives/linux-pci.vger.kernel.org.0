Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4346D8BF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhLHQq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 11:46:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50478 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHQq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 11:46:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A22EBB821B4;
        Wed,  8 Dec 2021 16:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8335EC00446;
        Wed,  8 Dec 2021 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638981803;
        bh=jcpHG83m7PROfurP8fPRZaOM1QoQXDXZ+HoP8/jB2JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7oVdEbiV1Kft7nFFhyglEewqrJrNpjuVUyoB/I2wBpgPskoEZEDP+rrjbFKBL82n
         H3g83cL9WQWF88Ej995bvcsdSHLJMBlPkUQj1b7UcF28v30R0ShiemAQMhIJEkBcPu
         dGkbfZDI8jJhyusukiLczXkRIogbGUOXnqbE41av39ZsOVQV+iBzKR2MkLlOIihcSi
         d6BpT1wJMoT+7jOKKhqhr2LgLsN8RZgsJGtPcKEVHxyml5+hdkSH50IQ9FJbGsJkud
         5sVvy4MjGW7WYt37UUU3Jb8PuzudFIqi0m4D2SIeX08PJVeb9inZ1L183L9iBRU7Nk
         IhhfWIMXfkr/g==
Date:   Wed, 8 Dec 2021 08:43:20 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 4/6] platform/x86: Add Intel Software Defined
 Silicon driver
Message-ID: <20211208164320.GB3852685@dhcp-10-100-145-180.wdc.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208015015.891275-5-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 05:50:13PM -0800, David E. Box wrote:
> +		This folder contains interface files for accessing Intel

s/folder/directory ?
