Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716C6CCF2E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 03:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjC2BCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 21:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC2BCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 21:02:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478126A0
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 18:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680051769; x=1711587769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+9L2EipOGTMYyPShzUzxm3RNOvbMeofXYnqMKuQMHok=;
  b=IytGS8wvRSH27oZOiHu/aSX170yFsD1+A/xVxDOOUa5UjuGidNJrZRAc
   30TNipdoc1s31VnbIDy1gYzYHQm1+4PMGqwpO9pShTdzDqJSOI9Kf4MQA
   gbLp9iDt03nhu5PHEAKhrKNf8huB2JHy6cYLQFBo9bv+WuumYpMTspTgu
   fKwvfZg0lhNM4zPho+eJp2GmcskDHX2ouM01uUE/ytb/3RugJjki36D6p
   G1zXm5vI+s5fYY4X0GgST6mgYyBv0CpBpx42DUclQX1pmwNJIhD+9H3Qa
   6ETQB/aI+OQZA6izGivHDscQ08V7XjBJi1rKb0DamPdDBiNWrhXqb0wLa
   A==;
X-IronPort-AV: E=Sophos;i="5.98,299,1673884800"; 
   d="scan'208";a="338813226"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 09:02:48 +0800
IronPort-SDR: TdcoXwNYUTsi9Xjq6DykNHSfRkVHf0xZFPY66su3v9/GX51io/G26TWc2vgZp6pwAoo5kk55R3
 eXuXv1twwia3ZbAeXinCO+U6FL1pggy2Bw9JgBsum38kjj+GLct/Iy6sE5Kpw0DoKeCY6yCbtP
 QyYkkbWy4hE6I/0xfah00+dognBpbcmtEN0q6/p+07vRFVf65Qx34i3j6exUpRQiINnEEIXZLo
 UPOtK8L2oQjLsnkNFa8+giw19N1fFz3zqScdVuUFS1tLccLAnRpWZLl1ghhoJJlQwRwjfWBVN7
 MwI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2023 17:18:58 -0700
IronPort-SDR: AcPyBtHZqr5gDZWqvi9JBJtEU/EXIN0nKN45XHWkN3giq4gsniK63BxDy+keuU0ySVYxa7e1UD
 QcMJ/DsBt4pyArjlo5mOdJ44feM7I7lCZ6DlAybZdw0evXURP8jXPBZoFDQY8LlERMt1QVStOZ
 KvprDJmD54IncO4HDc3vN2pklmsN/Q1jQtP/Rt9Uhhqg1s+//46Lzm1Tx93vjuo+CeIusENds1
 L9pLtpYAnld1k80rpzVT2J+yU0s0TQxREetM/Y764aVsX1C9lUXod1l0P+RZ9NIapn/fGjQ0AF
 Rfg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2023 18:02:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmSvr20K6z1RtVv
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 18:02:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680051767; x=1682643768; bh=+9L2EipOGTMYyPShzUzxm3RNOvbMeofXYnq
        MKuQMHok=; b=LPMSvau7sHmXF8yHbtsW3I1MyVh6ZzM9jrTURodQhAjPmuZrkec
        PkT+f3d8UtO7nXLSHE8lnVOp5KrwPcw68q/z4xuENR/b+zD7yBAugY98f0seMH1i
        wr9B4/Hds6dqD01bbUPwazob66KGQHHuOq3fdpn6b8dPrSCDlPqYOYxY6/hGdgrS
        AMYgmr3jrzag0lJfqD7OdG2YgZrF8quFpusUZxzxqg1p0JERwswdGMc0rKV3g950
        7cKKJV2ziTxPz+gOB+XnYR4WBGXEr6hGyaHNdLsFf02+D8Hsso1uWSFhkpbMUU1W
        XTBfZI9W1DgRimoY177oUpROD2WRDPfkuFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8heEBaEKl3Ce for <linux-pci@vger.kernel.org>;
        Tue, 28 Mar 2023 18:02:47 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmSvn6PVdz1RtVm;
        Tue, 28 Mar 2023 18:02:45 -0700 (PDT)
Message-ID: <d7b9086b-298a-03c4-2117-e4987c833469@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 10:02:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/16] PCI: epf-test: Cleanup
 pci_epf_test_cmd_handler()
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
 <20230325070226.511323-11-damien.lemoal@opensource.wdc.com>
 <CAAEEuhq_T9KGJoBcDNOC_+8ktAUr91xys0aRqQCXz3nN0W72Xg@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhq_T9KGJoBcDNOC_+8ktAUr91xys0aRqQCXz3nN0W72Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/23 15:56, Rick Wertenbroek wrote:
> On Sat, Mar 25, 2023 at 8:02=E2=80=AFAM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> Command codes are never combined together as flags into a single value=
.
>> Thus we can replace the series of "if" tests in
>> pci_epf_test_cmd_handler() with a cleaner switch-case statement.
>> This also allows checking that we got a valid command and print an err=
or
>> message if we did not.
>>
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++---------=
-
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/p=
ci/endpoint/functions/pci-epf-test.c
>> index fa48e9b3c393..c2a14f828bdf 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -676,41 +676,39 @@ static void pci_epf_test_cmd_handler(struct work=
_struct *work)
>>                 goto reset_handler;
>>         }
>>
>> -       if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
>> -           (command & COMMAND_RAISE_MSI_IRQ) ||
>> -           (command & COMMAND_RAISE_MSIX_IRQ)) {
>> +       switch (command) {
>> +       case COMMAND_RAISE_LEGACY_IRQ:
>> +       case COMMAND_RAISE_MSI_IRQ:
>> +       case COMMAND_RAISE_MSIX_IRQ:
>>                 pci_epf_test_raise_irq(epf_test, reg);
>> -               goto reset_handler;
>> -       }
>> -
>> -       if (command & COMMAND_WRITE) {
>> +               break;
>> +       case COMMAND_WRITE:
>>                 ret =3D pci_epf_test_write(epf_test, reg);
>>                 if (ret)
>>                         reg->status |=3D STATUS_WRITE_FAIL;
>>                 else
>>                         reg->status |=3D STATUS_WRITE_SUCCESS;
>>                 pci_epf_test_raise_irq(epf_test, reg);
>> -               goto reset_handler;
>> -       }
>=20
> As a minor improvement on this cleanup I would suggest either switching
> the if / else condition above or the two below, the inverted logic make=
s it
> confusing. (one test case is if (ret) and the two others are if (!ret) =
with
> inverted results, all could share the same code (same logic)).

Indeed, good idea. I will add one more patch to do that.

>=20
>> -
>> -       if (command & COMMAND_READ) {
>> +               break;
>> +       case COMMAND_READ:
>>                 ret =3D pci_epf_test_read(epf_test, reg);
>>                 if (!ret)
>>                         reg->status |=3D STATUS_READ_SUCCESS;
>>                 else
>>                         reg->status |=3D STATUS_READ_FAIL;
>>                 pci_epf_test_raise_irq(epf_test, reg);
>> -               goto reset_handler;
>> -       }
>> -
>> -       if (command & COMMAND_COPY) {
>> +               break;
>> +       case COMMAND_COPY:
>>                 ret =3D pci_epf_test_copy(epf_test, reg);
>>                 if (!ret)
>>                         reg->status |=3D STATUS_COPY_SUCCESS;
>>                 else
>>                         reg->status |=3D STATUS_COPY_FAIL;
>>                 pci_epf_test_raise_irq(epf_test, reg);
>> -               goto reset_handler;
>> +               break;
>> +       default:
>> +               dev_err(dev, "Invalid command\n");
>> +               break;
>>         }
>>
>>  reset_handler:
>> --
>> 2.39.2
>>

--=20
Damien Le Moal
Western Digital Research

