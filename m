Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79356395068
	for <lists+linux-pci@lfdr.de>; Sun, 30 May 2021 12:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhE3KXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 May 2021 06:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhE3KXC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 30 May 2021 06:23:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B62E360FDA;
        Sun, 30 May 2021 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622370084;
        bh=FkZX4tVfA2tdfHl8oN+s/MKIUrqxemY8/w6X6iyTW+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkhthsx11REgqbAoyifLxBvVP3wMvaLYU+AUeFM2VAZTuhMLfhzQ/fZCsQSAPepKc
         lazGHds/OCNgVBL6mZv79w9e2mf8qKdYEOyqz7ErjMgnleHvRqs8oshJhtEPTP3bXy
         sgioADgcfMecWfWmoTYBOaS8SYXXsJQM4/W3V6VK1S4gSkFM51J5ZF0pGeFNwnb7Sd
         Wn1psni1QDZrDJFaQf6H3CCNopqTtMTOnX4mslCksHSvy7NSKaOblUlxIYHfEzdOXT
         KEcLSHCQfgt9bbmFBUyHAdRjnZDH/kMRx3uuPCAIfUmyGJIweh5OAMVLeDDJLNsC5X
         M92zJatXWgEag==
Received: by pali.im (Postfix)
        id 38D931214; Sun, 30 May 2021 12:21:22 +0200 (CEST)
Date:   Sun, 30 May 2021 12:21:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     =?utf-8?B?UsO2dHRp?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Max Payload Size quirk for ASMedia ASM1062 SATA
 controller
Message-ID: <20210530102122.rvyh3qi3alptj5pr@pali>
References: <20210317225544.fm4oyuujylsxa77b@pali>
 <20210317230355.GA95738@bjorn-Precision-5520>
 <20210319190228.xdejimfdpjch6de4@pali>
 <cac9265e1c53638eca1aebe8a18bebc2@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac9265e1c53638eca1aebe8a18bebc2@posteo.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 21 March 2021 16:09:33 Rötti wrote:
> With these patches supplied (@thank you very much Marek & Björn) is there a
> build server I can download a nightly version of armbian I can test for you?
> Is there any way I can support?

Hello Rötti! For Armbian support you need to contact Armbian people.
Only they can include this patch into their build system and prepare
a patched Armbian kernel for you. Try to fill bug report on their
github issue tracker.
