Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98697543CE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjGNUgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 16:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGNUf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 16:35:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7235AD;
        Fri, 14 Jul 2023 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689366958; x=1720902958;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zDj72u9E9a3wZCG32UrWexGXSZP8EqG3M+2b/gTOMaY=;
  b=d4zUPIa6tE0doq0jVFhKGkM+fa86i7T8mQecal3NgcL7bBmPgd9xovmU
   ZL8MoUEKkCkZP0dyHyjZIYl7IbFtPRpX5huyrclMBK0Ublg8XfqKbMHCg
   aCf0nzPQaS5K6nGjRX6GxXqXW8xzFYh5Z/uksVgPacXlnCthKsRjI7eLj
   U2RNylrq6tYAAhuHTdguqgVgfTb21rcz5wFE9Wbg54nOLBB6NFI+E/qq3
   bbhx+xRiq+EAX8ta1Q5SSUUZegEyIwkfX3bzt4EMEia39DMdh8OkpSp1i
   Ur8xU3FekS0d77Vx+0O192ldrvGPG6pW5f7BGKpmBLjgQqbiLnnP6FyGm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431749280"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="431749280"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="1053197010"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="1053197010"
Received: from jkchitra-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.5.179])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:35:56 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        linux-pci@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] igc: Ignore AER reset when device is suspended
In-Reply-To: <20230714145445.GA354014@bhelgaas>
References: <20230714145445.GA354014@bhelgaas>
Date:   Fri, 14 Jul 2023 13:35:55 -0700
Message-ID: <874jm6nsd0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
>> When a system that connects to a Thunderbolt dock equipped with I225,
>> like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
>> ...
>
>> The issue is that the PTM requests are sending before driver resumes the
>> device. Since the issue can also be observed on Windows, it's quite
>> likely a firmware/hardware limitation.
>
> Does this mean we didn't disable PTM correctly on suspend?  Or is the
> device defective and sending PTM requests even though PTM is disabled?
>

The way I understand the hardware bug, the device is defective, as you
said, the device sends PTM messages when "busmastering" is disabled.

> If the latter, I vote for a quirk that just disables PTM completely
> for this device.
>

My suggestion is that adding this quirk would be a last resort kind of
thing. There are users/customers that depend on the increased time
synchronization accuracy that PTM provides.

> This check in .error_detected() looks out of place to me because
> there's no connection between AER and PTM, there's no connection
> between PTM and the device being enabled, and the connection between
> the device being enabled and being fully resumed is a little tenuous.
>
> If we must do it this way, maybe add a comment about *why* we're
> checking pci_is_enabled().  Otherwise this will be copied to other
> drivers that don't need it.

Makes total sense, from my side.

>
>> So avoid resetting the device if it's not resumed. Once the device is
>> fully resumed, the device can work normally.
>> 
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216850
>> Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> 
>> ---
>> v2:
>>  - Fix typo.
>>  - Mention the product name.
>> 
>>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 9f93f0f4f752..8c36bbe5e428 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -7115,6 +7115,9 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>>  	struct net_device *netdev = pci_get_drvdata(pdev);
>>  	struct igc_adapter *adapter = netdev_priv(netdev);
>>  
>> +	if (!pci_is_enabled(pdev))
>> +		return 0;
>> +
>>  	netif_device_detach(netdev);
>>  
>>  	if (state == pci_channel_io_perm_failure)
>> -- 
>> 2.34.1
>> 
>

-- 
Vinicius
