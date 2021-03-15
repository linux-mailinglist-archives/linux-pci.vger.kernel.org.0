Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9919333BD6A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 15:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhCOOfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 10:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236181AbhCOOeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615818883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE4MXpTy1s3he7taiWasf89xOhGqDGcYELJJK6u3UHE=;
        b=YkZHs1NCS4jII1JsqhuD72Fb4/MtjvJp7ACtKtB2S3Lgbyrx8eZJpwqbOieTkNGBZPJBYT
        M1HEuApqWGtI/wAJBLwBtpgHRtRUnGWMWWzdsXXBsvxsCqk6puqJR2woQKoBfd+cwlgYHV
        59pZD0K2eHsNpXsJ4wwrAUmVuHROC7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-fLspmacGMXOIVy7I9GZFiQ-1; Mon, 15 Mar 2021 10:34:40 -0400
X-MC-Unique: fLspmacGMXOIVy7I9GZFiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D481007EF7;
        Mon, 15 Mar 2021 14:34:10 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBF62614ED;
        Mon, 15 Mar 2021 14:34:09 +0000 (UTC)
Date:   Mon, 15 Mar 2021 08:34:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315083409.08b1359b@x1.home.shazbot.org>
In-Reply-To: <20210315135226.avwmnhkfsgof6ihw@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
        <20210312173452.3855-5-ameynarkhede03@gmail.com>
        <20210314235545.girtrazsdxtrqo2q@pali>
        <20210315134323.llz2o7yhezwgealp@archlinux>
        <20210315135226.avwmnhkfsgof6ihw@pali>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Mar 2021 14:52:26 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > slot reset (pci_dev_reset_slot_function) and secondary bus
> > reset(pci_parent_bus_reset) which I think are hot reset and
> > warm reset respectively. =20
>=20
> No. PCI secondary bus reset =3D PCIe Hot Reset. Slot reset is just another
> type of reset, which is currently implemented only for PCIe hot plug
> bridges and for PowerPC PowerNV platform and it just call PCI secondary
> bus reset with some other hook. PCIe Warm Reset does not have API in
> kernel and therefore drivers do not export this type of reset via any
> kernel function (yet).

Warm reset is beyond the scope of this series, but could be implemented
in a compatible way to fit within the pci_reset_fn_methods[] array
defined here.  Note that with this series the resets available through
pci_reset_function() and the per device reset attribute is sysfs remain
exactly the same as they are currently.  The bus and slot reset
methods used here are limited to devices where only a single function is
affected by the reset, therefore it is not like the patch you proposed
which performed a reset irrespective of the downstream devices.  This
series only enables selection of the existing methods.  Thanks,

Alex

