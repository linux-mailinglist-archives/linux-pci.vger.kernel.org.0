Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E086F228301
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGUPCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 11:02:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728064AbgGUPCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595343720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSIJqWa6gC/bRdgGTlEg6I1iiFHrJPO8X4/n8B0VJ9k=;
        b=Nda5GaqhA26gAUvQOiiVuv5CLb1nMr/9We8VKvxj1kezCWbLFkwDKZkU6MVLH1Ldj4B43z
        /exCwjMzKtEhIZmaArgCevLjTafzeTxg5W3i+ilaPGEjEiw7W+wjcphRDpAm6C2kq7L879
        +b4lHQFzsVn9UBIOTUqeas+caVWWx/k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-yEpAqgPUPzKkLeGXLHa-8Q-1; Tue, 21 Jul 2020 11:01:58 -0400
X-MC-Unique: yEpAqgPUPzKkLeGXLHa-8Q-1
Received: by mail-qv1-f72.google.com with SMTP id g17so12521340qvw.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 08:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=mSIJqWa6gC/bRdgGTlEg6I1iiFHrJPO8X4/n8B0VJ9k=;
        b=mgWgr6zHlgCLFIED3N6zlSAydWXVDDiWkmaDc6aUNBkZYGNM1TbrCSK19XQUbxZ3ya
         oqahPM3M9m4X2z93tbimLwSDeV7adFs6Zahx4Y0a0cjXmE+E/v4cznTI3tXUgleZR1eK
         5saldYYpjY7HxdB41ufci0u0UwNHCVpyXwZiVFx40gq5zqGyAwkA08HrrA8wGjcbqaiB
         hjsER9tXgxeqo5J1hTEcKyo31r5E/0rDs87aNr0uXKFdTE+pgvIKDb9FBVngdHN6Y1vP
         DBfzPfCrk3/IMQ5i+BlIx88HBONRDI6UsXrW/tMo6+/pyaZjc3rNj6ZVFTnraOEW6/ci
         bBvQ==
X-Gm-Message-State: AOAM532lfGAiwvpYngvJf1NEEPggy5sMciUUJ+Vxsau89rg4Nc0Oa9ue
        AroG2ezE8GV8nk9HJxVerDs8J1F1l/XGNItc16hU/LaDP4prCv2m2VGjuhp7TlS+obbdyurfoi6
        iFz0UqSWglqJbxBOkr/5m
X-Received: by 2002:a37:a51:: with SMTP id 78mr16530740qkk.121.1595343717905;
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJH5IxpTv0tqc1DLQ+iSUR4KYz9tNO0jJWsz8BvtZ9Y/QpYN7MJ20Jq9ljgK+EQmQWXFPL4g==
X-Received: by 2002:a37:a51:: with SMTP id 78mr16530715qkk.121.1595343717650;
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f4sm22024521qtp.38.2020.07.21.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
Message-ID: <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
From:   Lyude Paul <lyude@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Tue, 21 Jul 2020 11:01:55 -0400
In-Reply-To: <20200721122247.GI5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
         <20200716235440.GA675421@bjorn-Precision-5520>
         <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
         <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
         <20200721122247.GI5180@lahna.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sure thing. Also, feel free to let me know if you'd like access to one of the
systems we saw breaking with this patch - I'm fairly sure I've got one of them
locally at my apartment and don't mind setting up AMT/KVM/SSH

On Tue, 2020-07-21 at 15:22 +0300, Mika Westerberg wrote:
> Hi,
> 
> [Sorry for the delay, I was on vacation]
> 
> On Fri, Jul 17, 2020 at 01:32:10PM +0200, Karol Herbst wrote:
> > Filed at https://bugzilla.kernel.org/show_bug.cgi?id=208597
> 
> Thanks for reporting.
> 
> I'll check your logs and try to figure if there is something we can do
> to make both nouveau and TBT working at the same time.
> 
> > oddly enough I wasn't able to reproduce it on my XPS 9560, will ping
> > once something breaks.
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

