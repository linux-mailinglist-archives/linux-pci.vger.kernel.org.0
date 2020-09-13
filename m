Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE72681C6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 00:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgIMWuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgIMWue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2020 18:50:34 -0400
X-Greylist: delayed 129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Sep 2020 15:50:32 PDT
Received: from mxa2.seznam.cz (mxa2.seznam.cz [IPv6:2a02:598:2::90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F5C06174A
        for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2020 15:50:32 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc6b.ng.seznam.cz (email-smtpc6b.ng.seznam.cz [10.23.13.165])
        id 320adb1c0bbc07753215d10c;
        Mon, 14 Sep 2020 00:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1600037429; bh=uZ9A9of/oYsltsHKS79UJvGzVp64MRqCrfwdvqlWL78=;
        h=Received:To:Cc:References:Subject:In-Reply-To:From:Message-ID:
         Date:User-Agent:MIME-Version:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=IEY5rXR4UCCILXQpnDibpPvn5Z7nY5rKhmZIxzEy4SUGtwn7jWnGicysjyqonYDif
         9Kv1dDRdXmiKWVCtUaiZ0THe6XhBuVxnFEThXo0W935CZAvlLyIpboJtNj0D11mfuG
         It/mwZ3zE+NcQpKYK+STtk7GksMv+HqM/8of6vhQ=
Received: from [192.168.192.204] (78-80-120-19.nat.epc.tmcz.cz [78.80.120.19])
        by email-relay17.ng.seznam.cz (Seznam SMTPD 1.3.120) with ESMTP;
        Mon, 14 Sep 2020 00:48:09 +0200 (CEST)  
To:     helgaas@kernel.org
Cc:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org
References: <20200723201403.GA1450503@bjorn-Precision-5520>
Subject: Re: touchpad doesn't work at all on ACER Spin 5
In-Reply-To: <20200723201403.GA1450503@bjorn-Precision-5520>
From:   =?UTF-8?Q?Martin_crysman_Zahradn=c3=adk?= <crysman@seznam.cz>
Message-ID: <da857d4f-ad6f-863a-893d-f05fcbdde44e@seznam.cz>
Date:   Mon, 14 Sep 2020 00:48:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

please, any chance somebody would help to fix this issue? Thanks a lot #McZ

