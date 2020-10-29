Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3880C29F60C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ2USy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 16:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgJ2USx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 16:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604002730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5juAGsCE3PI0S1NeizXuupxQDSrndPfAhE3xLQEG7A=;
        b=Rgo4oHQ2+9PVr76FGRS9ItpfMpuk6A7RLsXZoK7MBO2sMYOIps13yYi2pmy8rfaXqZgTCF
        O0yTXJuWTMDBUo4u18neb/1ez1zzMYFxKdBceQoEx+yINiGXaXN+E0f0ijEm/qOyRY9taX
        mxnrLLWAH+ubko0Gnn2y9aLEZANu7Mo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-jWWqehlKMBuu7OultIULqw-1; Thu, 29 Oct 2020 16:18:45 -0400
X-MC-Unique: jWWqehlKMBuu7OultIULqw-1
Received: by mail-qt1-f199.google.com with SMTP id 2so2629080qtb.5
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z5juAGsCE3PI0S1NeizXuupxQDSrndPfAhE3xLQEG7A=;
        b=bESFEV3VUhNi+F7snjfc7IAVm3xZzwQJby/Y+3Ch22wc1xAgUsIAejd+njjtc8dJ4I
         rshhOoksxLFgfIn8CHckUgYyDHBsxLhCpp8gTjtaiQ5tPQtFhb3ee+eXJ4T78KDVXJJN
         oNHyLTj8WM0FdFchkeskalpUk6reU2GGmo6q+JAyESdD4flwiNTIRKwrhQVMfsSHnvfu
         xBovK5aqTMnd6oFmxPQBM0d+h/z2lporM68iYtqgja+6XueO8mPdljIhg3UV2+lNSQin
         ayjb55iiRToq4Zkw5dPLJlqwjDHU8hg1hdro42pDAaDYmctVdByLFfAAF7Do0Rr9VUGE
         jBRg==
X-Gm-Message-State: AOAM531KXeWGfOdXgwbd0BpNbwgGB6VMVnJgixvUObcCsoCdbGi0BSNy
        D9jyN7+SsgskpdPlt5VOrql88a60McVYnTFzjNeZbO8oiznlBzUPEsK0k3cSYmcKPyh1akgJrGw
        mwDJq9d/154a7alfpcJwu
X-Received: by 2002:a37:4ca:: with SMTP id 193mr5630577qke.346.1604002724837;
        Thu, 29 Oct 2020 13:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxrQ2Z7nRugCHkvwzUeAjsi2hEkLYmWU55M4/37KHh6ogtQ1GBxpoqe/ZhJXb5Vr95kX5h1Q==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr5630530qke.346.1604002724072;
        Thu, 29 Oct 2020 13:18:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q7sm1618156qtd.49.2020.10.29.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:18:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 15D70181AD1; Thu, 29 Oct 2020 21:18:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>
References: <20201029193022.GA476048@bjorn-Precision-5520>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Oct 2020 21:18:40 +0100
Message-ID: <871rhgpyzj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> Another experiment: build kernel without CONFIG_PCIEASPM, set $ROOT
> and $NIC appropriately, and try the following:
>
>   # Set $ROOT and $NIC (update to match your system):
>
>     # ROOT=00:02.0
>     # NIC=02:00.0

(these matched the ath10k card, so just went with that)

>   # Dump the Root Port and NIC Link registers:
>
>     # setpci -s$ROOT CAP_EXP+0xc.l              # Link Capabilities
>     # setpci -s$ROOT CAP_EXP+0x10.w             # Link Control
>     # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status

# setpci -s$ROOT CAP_EXP+0xc.l
0003ac12
# setpci -s$ROOT CAP_EXP+0x10.w
0040
# setpci -s$ROOT CAP_EXP+0x12.w
1011

>     # setpci -s$NIC  CAP_EXP+0xc.l              # Link Capabilities
>     # setpci -s$NIC  CAP_EXP+0x10.w             # Link Control
>     # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

# setpci -s$NIC CAP_EXP+0xc.l
00036c11
# setpci -s$NIC CAP_EXP+0x10.w
0000
# setpci -s$NIC CAP_EXP+0x12.w
1011

>   # Retrain the link:
>
>     # setpci -s$ROOT CAP_EXP+0x10.w=0x0020      # Link Control Retrain Link
>     # sleep 1
>     # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
>     # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

# setpci -s$ROOT CAP_EXP+0x10.w=0x0020
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
setpci: 0000:02:00.0: Instance #0 of Capability 0010 not found - there are no capabilities with that id.
# setpci -s$ROOT CAP_EXP+0x10.w
0000

(nothing in the dmesg either) - rebooted before trying the below:

>   # Set CommClk+ and retrain the link:
>
>     # setpci -s$NIC  CAP_EXP+0x10.w=0x0040      # Link Control Common Clock
>     # setpci -s$ROOT CAP_EXP+0x10.w=0x0040      # Link Control Common Clock
>     # setpci -s$ROOT CAP_EXP+0x10.w=0x0060      # Link Control RL + CC
>     # sleep 1
>     # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
>     # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

# setpci -s$NIC CAP_EXP+0x10.w=0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=0x0060
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
setpci: 0000:02:00.0: Instance #0 of Capability 0010 not found - there are no capabilities with that id.

# lspci -v
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04) (prog-if 00 [Normal decode])
        Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@1,0
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: e0000000-e00fffff [size=1M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Expansion ROM at e0100000 [virtual] [disabled] [size=2K]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
lspci: Unable to load libkmod resources: error -12

00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04) (prog-if 00 [Normal decode])
        Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@2,0
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: e0200000-e04fffff [size=3M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Expansion ROM at e0500000 [virtual] [disabled] [size=2K]
        Capabilities: [40] Express Root Port (Slot+), MSI 00

00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04) (prog-if 00 [Normal decode])
        Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@3,0
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: e0600000-e07fffff [size=2M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Expansion ROM at e0800000 [virtual] [disabled] [size=2K]
        Capabilities: [40] Express Root Port (Slot+), MSI 00

01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
        Subsystem: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express)
        Flags: bus master, fast devsel, latency 0, IRQ 60
        Memory at e0000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
        Capabilities: [60] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170] Power Budgeting <?>
        Kernel driver in use: ath9k

02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter (rev ff) (prog-if ff)
        !!! Unknown header type 7f
        Kernel driver in use: ath10k_pci

03:00.0 Network controller: MEDIATEK Corp. Device 7612
        Subsystem: MEDIATEK Corp. Device 7612
        Flags: bus master, fast devsel, latency 0, IRQ 63
        Memory at e0600000 (64-bit, non-prefetchable) [size=1M]
        Expansion ROM at e0700000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Kernel driver in use: mt76x2e


-Toke

