Return-Path: <linux-pci+bounces-17089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B717D9D2D82
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784D02804A3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB51CF7BE;
	Tue, 19 Nov 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uw5RJAYM"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic305-2.consmr.mail.bf2.yahoo.com (sonic305-2.consmr.mail.bf2.yahoo.com [74.6.133.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FC1CEAAA
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039457; cv=none; b=PjelBLJalVfKQQZAZ3EK3nDSuy49vj2nhljOt5IEh8RTiyEuEKeCJsNnzA54RawPtJ0kVK5FoPD9SC4WM0LKqnq7ZiRAPtAkTGh94/5AM01FZD0U9eKxUODyWqaCh+qhF5QJXUAgex2Ok6XiFIxc9RzkSOJv1wul71EnZp6WzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039457; c=relaxed/simple;
	bh=GNa3ChoMIqWxWnbpwvmXRlBy1PuGYde61ukwVSxpdQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOA+24l2BxwNZB/ypun8dI4YU9hO+zLCWvX73k7mVaIMmEOczbBUmk2e1/z52K4JZpXbbqjqTr/NBtgVElFoIs2MWSZf3JTob7sW5aZYYEBQ+r07u3GeAr1xzOZCoqwWqvP5VET99asA3dGxxYvrRFCasZUa1IuiXc0kdnjWshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Uw5RJAYM; arc=none smtp.client-ip=74.6.133.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732039453; bh=TuwroC3uYqmOOslIUilzElifcjVfYau1dkOQl6z5gIY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Uw5RJAYMBwBHX2pLLxGdjqtA0PbNlD+EiuEit3qpCFzfPOF6w+b9diOF/Vh0EGmYoMLHrHHvtT5B9NrWfwvBud4ccPN4oLtQN9hYH7euZV84xubc1HW8crkmyMErQZUEqKIP+rCAvEzxPMPS8HQ4N35b3GZbgpWqV8gb09ccMAf8sDD4ETCIG7hRxi7OC33FB2saWegJ+0OfiIIUiMaBcsCBtTtDlZ24O3hs/g5++wUtuzawHWKEMbtkcdlE0Wm/w2vmhJ3+iZxWOeaOooEh2HMif2Lmbs46KCgLGHmZBxXK8mBw1m+f8PKmF7qy8OwlUFHWaS7L5NKwH0o/db/mUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732039453; bh=LyRK2fUiRLsTDi/oXvu0inkDAG3uZNy/QE5Ycm2Qiah=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EXf1gNGWUgFeB83P8C1E0cZ3DAacw8eT67sEUbP6e6CoHO61rY0I9DCaNWCh8gB7QQ98L6of/mXgYa0N2vhgU5a9uRplrZzxwuHhB6evUPxVj4NI7DPZajNq2jiiAouONdA3znjqR8cmrAbS213f1wKxKBJa6FQOXxyc58pyJzpl6lmdI4YSA4jaSglBQyzKTEnLMsB1zIRcBw/PuXc74QM80VVHYm1OYgbjLieUjg026CQ1UHoHONI1gUAMnO1XMgvw0t33sRxfsSsZUlLuCrdgZi9a5vEVYCp8kdjn/CidhkyFhMghXEgxWVFBRitAN8SWmkEdY1Z3qXozEbAhWg==
X-YMail-OSG: qGWTCFkVM1lxWHNC6tevImQONlkLAmDo17tvqQNbHZ1nmU7FPWkn08pjb9aFspC
 CssZ3fy4N55bP2e6XmV8B1.YHcExqLMdU5qBDdX.VzT7LhnQiO1j6p49cO0rncAIv08XToWmuXV5
 Mkju7FSDy2c0wk.PYNqUrK_bG5dMs2j6YzshISCD8U3RqeRFKRL_WsDAk2mY0d_BRrUipebIvZRB
 bTEhHbxM0MJkAybbg_.VScDJSKlErA.11PBrXOfFe077kgFi1AeLFzQNXoKbv8JjsvuPkWTw1g9k
 VFb6K0zWUjNY_pVr3BGyI39ZQk_VhXR3Y9okC7g3RBBc.9LeKstYEZc9eMKEpDeaI46EjvVuE_M7
 ioPuSYtmWRPjXEtyRq1TE0W2TEQwo.AxsfKuFVsFKFtvjpmndxjWRTNmRuGnW.9Dlr2eM6k5MQhY
 XISnu0vDV1ECAjmRlIXsvgoXnJL4wUvNYVSgeMl.BVo3ZMYgN4Fa3vGtmMD2gpJYFSVI326yj5zs
 zNSa87ScYUyYfhAdOdgrOTGn8e2rDJSyNKrpGynP2naFcUDTHXcL7EExHkLvsiy0gpcRdPM2Gg1N
 eXcBwkskSyGVq8_E5_iLd6ybGrqP49BBh0f_gkt0NWTcl7iVzEbIl2gYpoDkbUAbmmmd3ICxPSee
 UkxItVQj2kx7GrofYxYQXRwnfG0_8XktXjUcHRm8mXChhusU_x_LlPvfHlxKj.A39daGbydMvNey
 FbNR8G94yGzxuzPw88mftIEjTE8sxUNsp6N9soOLl468MXwv4C.RLlpHS9vWYW8O7DnqDE52NVop
 3J7SLLrNBWHOMQiy8l08Alltbd4jNZ8bTmw27IdR1ivfvVzT6zPzEobh8inkh5JzdtNaKjmXQscY
 t6crLCL5XkfGFosUJ3Azaa7TquuY7MDH2Fm4QGcQpFhzxXrwsYwc0NAZKObfzqrmsVHiazn4TxB7
 x5WbNR9WZEKA00Iv82MOrnqJiG.UGF4Wb8ENCYS9f5_wiFfUYibJxfqIsXdipwGPkIvM4dOgXWnK
 iBvbeYnGX2GzT3sp3lzmfUthGGjQTxML4zN3w5xoTzNNMdSnUJFD03D63tBwiod0jEnt4rEwbxKC
 TaO1d8CNI2g1.DGWx9SAStHESzCp9ZuX9LK9NGvTvQblmcgR_QntW58HpErxBr.VXsOddkkF2GEw
 cVlPKASSzxwx6q37Cf87C6.3thD676vodFGw17xoTDPRuzK8aYzyO5XPhPXHWM5nRdCrXCnW0wfP
 D6gTGbtOoSL40qgDqwoBuyKLWaDFO9egTlnwHTPTgS9xAbvM3570whSxNFKknZnT6bQzzR6RGClR
 q1jybiFu0LOUBtg7eP8xVUMTKQjSiA3B3GBj_KxPF0UpXktorOodRBuW.wP.MCG5SfoBDgUqNLQm
 _M2y0orn.2c99dg.CZ1c6GcVYTO3xNRVRNnjw.QSj8Jyb3St4O1S2g8Ige4Q434SomHY1n5on7Im
 pvVS3Vr8PdxVifTJx_k55dWcvrhVGEmuVJFct794y5iDIfPLFevDyQEuA1ib9TbVfa84cd4R7.Bl
 mDAl.76LFdQbM5XC76Qs3L2azfTehA9k5LIerWzmdCw5INCbdH3xmulHcUtqQXXJk6GAY.UZ1Npv
 ULgQgBv_hT1vWCG24DKXLeibTv2rR4ASKpSbpaxLK9y2aSYCFk14boM51OSRvve91JoBVGv830iY
 cSouEK.TD_srjGxqp2PEwbYJNqf4SyxH2jrT1AkVIQIsWQGJS43RvKZPd7ztUwEQ3LbmPmctfJu5
 .ub1q_WpXUPVQdGCMZuYlGwuAiElobpa2PVhB3WFKw4mlWuxlqGYp.4ljGwFX1dZ2uBk4kD3bHGF
 c4LoeXLurp6VbmndxqsKFWm_gzzvOFMSruZN4UhxXNaghEfbzUKpaNu6T9XDA1C71psw9RqZ8QzT
 BtM2a7Ryh7_ZXf2E2PxYldyXVWtFvYIfs4kt8v6JvOJzoUNmPN3q1OxowOVMJ4uP_Kdv5PGfgKg8
 fQzl3tHVly3fNns1HuO5aMpLU1sgo8AUBUZayaOJiow4Qa7YEnBEN8rP1vhaq0YjTQf08ulwfEDy
 HRjvQmESPfbJ8qdSsnRTt2Xo8MBhkH07zoiihIRLDfRC4aRcsue3hj0gn54FbV5aRWaIce9l4V2E
 suRzrHHaqoJGMRAaNxq.ZT.NvvPpFYMprbjHHjjJKY44GRc3BwUzaud2p5fBAZ80wQZcT1iIE4AX
 0d5_Ghcy0WiZ0k8FEN1oBfcANNL9fDJ83nVusMl.jSBAJ29YHgVoahqc0ytlC
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 0ea7f5f7-4208-4506-9546-760656c95884
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 Nov 2024 18:04:13 +0000
Received: by hermes--production-ne1-bfc75c9cd-8lptz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b83b3efedb6ddd19a8ee0957c0a3053;
          Tue, 19 Nov 2024 18:04:10 +0000 (UTC)
Message-ID: <37fb3ce4-058e-4dd4-8b2d-d18ced4e1862@yahoo.com>
Date: Tue, 19 Nov 2024 11:48:45 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <bug-219513-41252@https.bugzilla.kernel.org/>
 <20241119140434.GA2260828@bhelgaas>
 <CACMJSesxsADzGQyzi13QDGh-VwEO+mgyyGmSNEyyBiL6QRAWZw@mail.gmail.com>
 <52410459-d15b-4e18-a978-0c069f9cd292@yahoo.com>
 <20241119172704.skudguavz4nmdi4t@thinkpad>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <20241119172704.skudguavz4nmdi4t@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 11/19/24 11:27, Manivannan Sadhasivam wrote:
> On Tue, Nov 19, 2024 at 10:57:26AM -0600, Dullfire wrote:
>>
>> Bart: I attached to the bug report a dts extracted from the system.
>>
>> Just a FYI: SPARC systems (including linux) get their device tree from the
>> open firmware, which likely dynamically generates at least parts of it, so
>> there is not a discrete source for it.
>>
> 
> Thanks Jonathan for the dts drop! Looks like the platform devices for the pcie
> nodes were created elsewhere for the SPARC systems. Could you please test the
> below diff and see if it fixes the issue?
> 
> ```
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 7a061cc860d5..e70f4c089cd4 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -394,7 +394,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>          * PCI client drivers.
>          */
>         pdev = of_find_device_by_node(dn);
> -       if (pdev) {
> +       if (pdev && of_pci_is_supply_present(dn)) {
>                 if (!device_link_add(&dev->dev, &pdev->dev,
>                                      DL_FLAG_AUTOREMOVE_CONSUMER))
>                         pci_err(dev, "failed to add device link between %s and %s\n",
> ```
> 
> - Mani


Mani: Yup, that patch does the trick in my test case. The PCIe drivers all bound
and function.


Regards,
Jonathan Currier

