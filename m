Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE758F9B3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 06:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHPEWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 00:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfHPEWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 00:22:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 160B085537;
        Fri, 16 Aug 2019 04:22:15 +0000 (UTC)
Received: from [10.3.117.107] (ovpn-117-107.phx2.redhat.com [10.3.117.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7E6084256;
        Fri, 16 Aug 2019 04:22:13 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] PCI: Clean up pci-sysfs.c
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, gregkh@linuxfoundation.org
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-1-skunberg.kelsey@gmail.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <d993838c-310c-60bd-b788-ab669bf08566@redhat.com>
Date:   Fri, 16 Aug 2019 00:22:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190815153352.86143-1-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 16 Aug 2019 04:22:15 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/15/2019 11:33 AM, Kelsey Skunberg wrote:
> This series is designed to clean up device attributes and permissions in
> pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
> iov.c for better organization.
> 
> Patch 1: Define device attributes with DEVICE_ATTR* instead of __ATTR*.
> 
> Patch 2: Change permissions from symbolic to the preferred octal.
> 
> Patch 3: Change DEVICE_ATTR() with 0220 permissions to DEVICE_ATTR_WO().
> 
> Patch 4: Move sysfs SR-IOV functions to iov.c to keep the feature's code
> together.
> 
> 
> Patch 1, 2, and 4 will report unusual permissions '0664' used from the
> following:
> 
>    static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show,
>                       sriov_numvfs_store);
> 
>    static DEVICE_ATTR(sriov_drivers_autoprobe, 0664,
>                       sriov_drivers_autoprobe_show,
>                       sriov_drivers_autoprobe_store);
> 
> This series preserves the existing permissions set in:
> 
> 
>    commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
>                          VF driver binding")
> 
>    commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> Either adding a comment verifying permissions are okay or changing the
> permissions is to be completed with a new patch.
> 
> Changes since v1:
>          Add patch 1 and 2 to fix the way device attributes are defined
>          and change permissions from symbolic to octal. Patch 4 which moves
>          sysfs SR-IOV functions to iov.c will then apply cleaner.
> 
> Changes since v2:
> 
>          Patch 1: Commit log updated. Example shows DEVICE_ATTR_RO()
>          example instead of DEVICE_ATTR(). DEVICE_ATTR() should be avoided
>          unless the files have unusual permissions. Changed to reflect a
>          more encouraged usage.  Also updated regex to be accurate.
> 
>          Patch 3: [NEW] Add patch to change DEVICE_ATTR() with 0220
>          permissions to DEVICE_ATTR_WO().
> 
>          Updated series log to reflect new patch and unusual permissions
>          information.
> 
> 
> Kelsey Skunberg (4):
>    PCI: sysfs: Define device attributes with DEVICE_ATTR*
>    PCI: sysfs: Change permissions from symbolic to octal
>    PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()
>    PCI/IOV: Move sysfs SR-IOV functions to iov.c
> 
>   drivers/pci/iov.c       | 168 ++++++++++++++++++++++++++++++
>   drivers/pci/pci-sysfs.c | 223 ++++------------------------------------
>   drivers/pci/pci.h       |   2 +-
>   3 files changed, 191 insertions(+), 202 deletions(-)
> 
Thanks for the cleanup.

Reviewed-by: Donald Dutile <ddutile@redhat.com>

