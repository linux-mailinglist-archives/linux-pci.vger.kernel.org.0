Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254F554F787
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiFQM2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382428AbiFQM2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 08:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F037C27B08
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655468923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbSTGo9DcH1pdUa0OUcLVQPy+Ei6rWlj/p/p0BQai8I=;
        b=aBH34CzsNNSbvGZiNYHhedd8wLts2HNgfO6oV4ntGdlj9wFKOYtZMYB21ZIQMgBEkHlNIB
        80REwoX8TqEZyIIXj0+yq9XJqTJ/W0OlOExhuAkPM8/35UxcjtwWFtgte3Zuc7M46mC0pd
        BldYorFC9OPOADEBoAZA9CsSfUuX80Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-N9tsnrjUNAeeytmKcU2WBw-1; Fri, 17 Jun 2022 08:28:40 -0400
X-MC-Unique: N9tsnrjUNAeeytmKcU2WBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E0833C0D1A5;
        Fri, 17 Jun 2022 12:28:40 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-0-23.rdu2.redhat.com [10.22.0.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E641121314;
        Fri, 17 Jun 2022 12:28:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Hans de Goede" <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        "Zack Rusin" <zackr@vmware.com>
Subject: Re: pci=no_e820 report for vmware fusion
Date:   Fri, 17 Jun 2022 08:28:38 -0400
Message-ID: <71D41FA6-BC7A-47C7-9F6C-A682E17FC793@redhat.com>
In-Reply-To: <20220616204020.GA1137352@bhelgaas>
References: <20220616204020.GA1137352@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16 Jun 2022, at 16:40, Bjorn Helgaas wrote:

> The badness would definitely be interesting (the entire dmesg log), as

Here it is:
https://bcodding.com/d/dmesg_pci_badness.txt

> well as a dmesg log collected with "pci=no_e820".  I'll attach them to
> this bugzilla [1].

https://bcodding.com/d/dmesg_pci_no_e820_param.txt

> Generally I expect PCI devices to work even if we reassign their BARs
> before a driver claims them.  But apparently some do not, and I'm
> always curious about which ones they are.
>
> If you could confirm that Hans' revert [2] avoids the problem without
> needing "pci=no_e820", that would be awesome, too.

I can confirm that the Hans' revert avoids the problem without having the
kernel param set.  I've only booted it, not done any other PCI testing.

Ben

